var page = require('webpage').create();
page.open('http://localhost:3000', function() {
  page.render('example.png');
  phantom.exit();
});
