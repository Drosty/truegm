@truegm.controller 'TopicShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->
  $scope.currentLeagueId = $routeParams.leagueId
  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $http.get("./leagues/#{$routeParams.leagueId}/topics/#{$routeParams.id}.json").success((data) ->
    $scope.topic = data
  )

  $scope.postsAvailable = ->
    $scope.topic.posts.length > 0 if $scope.topic

]
