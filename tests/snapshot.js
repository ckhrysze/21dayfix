var page =
  require('webpage').create(),
  system = require('system');

if (system.args.length !== 2) {
  console.log('Try to pass some args when invoking this script!');
} else {
  var day = system.args[1];

  page.open('http://localhost:3000/' + day, function() {
    page.render('day' + day + '.png');
    phantom.exit();
  });
}

