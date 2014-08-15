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
    when('/league/:leagueId/topics', {
      templateUrl: 'forumTopic/index.html',
      controller: 'TopicIndexCtrl'
    }).
    when('/league/:leagueId/topics/:id', {
      templateUrl: 'forumTopic/show.html',
      controller: 'TopicShowCtrl'
    }).
    when('leagues/:leagueId/player/:id', {
      templateUrl: 'player/show.html',
      controller: 'PlayerShowCtrl'
    }).
    otherwise({
      templateUrl: 'leagues/index.html'
      controller: 'LeagueIndexCtrl'
    })
])
