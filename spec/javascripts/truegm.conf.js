/*
  Note for myself:
  This is how to install Karma and get it started:

  sudo npm install -g karma
  sudo npm install -g karma-cli
  sudo npm install -g karma-jasmine
  sudo npm install -g karma-ng-scenario
  sudo npm install -g karma-coffee-preprocessor
  sudo npm install -g karma-chrome-launcher
  karma start spec/javascripts/truegm.conf.js
*/

module.exports = function(config) {
  config.set({
    basePath: '../..',

    frameworks: ['jasmine'],

    plugins : [
      'karma-jasmine',
      'karma-coffee-preprocessor',
      'karma-chrome-launcher'
    ],

    autoWatch: true,

    preprocessors: {
      '**/*.coffee': 'coffee'
    },

    files: [
      'app/assets/javascripts/angular.js',
      'app/assets/javascripts/angular-mocks.js',
      'app/assets/javascripts/main.js.coffee',
      'app/assets/javascripts/angular/controllers/LeagueIndexCtrl.js.coffee',
      'app/assets/javascripts/angular/*',
      'spec/javascripts/*_spec.js.coffee'
    ]
  });
};
