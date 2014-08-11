@truegm = angular.module('truegm', ['templates', 'ng-rails-csrf'])

@truegm.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/leagues', {
      templateUrl: 'leagues/index.html'
      controller: 'LeagueIndexCtrl'
    }).
    when('/league/:id', {
      templateUrl: 'leagues/show.html',
      controller: 'LeagueShowCtrl'
    }).
    when('/login', {
        templateUrl: 'authentication/login.html',
        controller: 'LoginCtrl'
    }).
    when('/logout', {
        templateUrl: 'authentication/logout.html',
        controller: 'LogoutCtrl'
    }).
    otherwise({
      templateUrl: 'home.html',
      controller: 'HomeCtrl'
    })
])
