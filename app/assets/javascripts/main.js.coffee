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
    when('/team/:id', {
      templateUrl: 'team/show.html',
      controller: 'TeamShowCtrl'
    }).
    otherwise({
      templateUrl: 'leagues/index.html'
      controller: 'LeagueIndexCtrl'
    })
])
