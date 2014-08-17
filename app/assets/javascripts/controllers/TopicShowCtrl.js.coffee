@truegm.controller 'TopicShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./leagues/#{$routeParams.leagueId}/topics/#{$routeParams.id}.json").success((data) ->
    $scope.topic = data
    $scope.currentLeagueId = data.league.id
    LeagueService.setOrUpdateLeagueById($routeParams.leagueId)
  )

  $scope.postsAvailable = ->
    $scope.topic.posts.length > 0 if $scope.topic

]
