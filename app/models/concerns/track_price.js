const fs = require('fs');
const file = '../app/models/concerns/updated_price.txt';
fs.writeFile(file, '', err => { if (err) throw err });

const links = process.argv.slice(2);

(async () => {
  const { firefox } = require('playwright');
  for (const link of links) {
    //open brower and go to link
    const browser = await firefox.launch();
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
    
    // add updated price to file
    fs.appendFile(file, `${price}\n`, err => { if (err) throw err });
  
    //close brower
    await browser.close();
  }
})();

