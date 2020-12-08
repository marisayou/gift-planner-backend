const fs = require('fs');
const file = 'app/models/concerns/updated_price.txt';

const { firefox } = require('playwright');
// const link = 'https://www.nordstrom.com/s/ugg-ansley-water-resistant-slipper-women/3164992?origin=keywordsearch-personalizedsort&breadcrumb=Home%2FAll%20Results&color=black%20suede';
// const link = 'https://www.nordstrom.com/s/free-people-cloud-rib-oversize-scarf/5842901?origin=keywordsearch-personalizedsort&breadcrumb=Home%2FAll%20Results&color=taupe';
const link = 'https://www.nordstrom.com/s/naturalizer-colby-platform-hiking-boot-women/5614978?origin=coordinating-5614978-0-1-PDP_1-recbot-visually_similar_type2_no_dresses&recs_placement=PDP_1&recs_strategy=visually_similar_type2_no_dresses&recs_source=recbot&recs_page_type=product&recs_seed=5629636&color=BLACK%20LEATHER';
// const link = process.argv.slice(2);

(async () => {
  fs.writeFile(file, '', err => { if (err) throw err });
  const browser = await firefox.launch({ headless: false });
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto(link);
  await page.innerHTML('div#selling-essentials');

  // initalize variables
  let dollars = '0.00';
  let cents = '';

  // if item is in stock, find the price
  const dollarsSpan = await page.$('span#current-price-string')
  if (dollarsSpan) {
    dollars = await dollarsSpan.innerText();
  }
  const centsSup = await page.$$('sup.YoQtN');
  if (centsSup.length !== 0) {
    cents = `.${await centsSup[1].innerText()}`
  }
  const price = (dollars + cents).replace('$', '');
  
  fs.appendFile(file, price, err => { if (err) throw err });

  await browser.close();
})();
