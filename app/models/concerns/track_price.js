const fs = require('fs');
const file = 'app/models/concerns/updated_price.txt';

const { firefox } = require('playwright');
// const link = 'https://www.nordstrom.com/s/ugg-ansley-water-resistant-slipper-women/3164992?origin=keywordsearch-personalizedsort&breadcrumb=Home%2FAll%20Results&color=black%20suede';
// const link = 'https://www.nordstrom.com/s/free-people-cloud-rib-oversize-scarf/5842901?origin=keywordsearch-personalizedsort&breadcrumb=Home%2FAll%20Results&color=taupe';
const link = process.argv.slice(2);

(async () => {
  fs.writeFile(file, '', err => { if (err) throw err });
  const browser = await firefox.launch({ headless: false });
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto(link);
  await page.innerHTML('section#product-page-price-lockup');

  const dollarsSpan = await page.$('span#current-price-string')
  const dollars = await dollarsSpan.innerText();
  let cents = '';
  const centsSup = await page.$$('sup.YoQtN');
  if (centsSup.length !== 0) {
    cents = `.${await centsSup[1].innerText()}`
  }
  const price = (dollars + cents).replace('$', '');
  
  fs.appendFile(file, price, err => { if (err) throw err });

  await browser.close();
})();
