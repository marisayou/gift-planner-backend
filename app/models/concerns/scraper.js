const fs = require('fs');
const file = 'app/models/concerns/search_results.txt';

const { firefox } = require('playwright');
const queryTerm = process.argv.slice(2);

(async () => {
  fs.writeFile(file, '', err => { if (err) throw err });
  const browser = await firefox.launch({ headless: false });
  // const browser = await firefox.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto(`https://www.nordstrom.com/sr?origin=keywordsearch&keyword=${queryTerm}`);
  await page.innerHTML('main#layer-0');
  
  let hasResults = await page.$('article.QIjwE');
  if (hasResults) {
    results = await page.$$('article.QIjwE');
    const displayNum = results.length < 12 ? results.length : 12;
    for (let i = 0; i < displayNum; i++) {
      
      const nameLink = await results[i].$('a._5lXiG');
      const name = await nameLink.innerText();
      const link = await nameLink.getAttribute('href');
      
      let priceDiv = await results[i].$('div._18N5Q') || await results[i].$('div._3bi0z');
      
      const priceSpan = await priceDiv.$('span._3wu-9');
      const priceStr = await priceSpan.innerText();
      const price = parseFloat(priceStr.slice(1).replace(',', ''));

      const img = await results[i].$('img.TDd9E');
      const imgURL = await img.getAttribute('src');

      fs.appendFile(file, `${name}<|>${price}<|>https://nordstrom.com${link}<|>${imgURL}\n`, err => { if (err) throw err });
    }
  }

  await browser.close();
})();

