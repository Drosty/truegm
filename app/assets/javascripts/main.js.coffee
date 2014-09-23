@truegm = angular.module('truegm', ['templates', 'ngAnimate', 'ng-rails-csrf', 'ngRoute', 'ui.bootstrap', 'angulartics', 'angulartics.google.analytics'])

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
    when('/league/:leagueId/team/:id', {
      templateUrl: 'team/show.html',
      controller: 'TeamShowCtrl'
    }).
    when('/league/:leagueId/topics', {
      templateUrl: 'forumTopic/index.html',
      controller: 'TopicIndexCtrl'
    }).
    when('/league/:leagueId/topics/new', {
      templateUrl: 'forumTopic/new.html',
      controller: 'TopicNewCtrl'
    }).
    when('/league/:leagueId/topics/:id', {
      templateUrl: 'forumTopic/show.html',
      controller: 'TopicShowCtrl'
    }).
    when('/league/:leagueId/topics/:topicId/post/new', {
      templateUrl: 'forumPost/new.html',
      controller: 'TopicPostNewCtrl'
    }).
    when('/league/:leagueId/players', {
      templateUrl: 'player/index.html',
      controller: 'PlayerIndexCtrl'
    }).
    when('/league/:leagueId/player/:id', {
      templateUrl: 'player/show.html',
      controller: 'PlayerShowCtrl'
    }).
    when('/league/:leagueId/activity', {
      templateUrl: 'activity/index.html',
      controller: 'ActivityIndexCtrl'
    }).
    otherwise({
      templateUrl: 'leagues/index.html'
      controller: 'LeagueIndexCtrl'
    })
])
