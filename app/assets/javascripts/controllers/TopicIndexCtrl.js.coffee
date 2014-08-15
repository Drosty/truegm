@truegm.controller 'TopicIndexCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./leagues/#{$routeParams.leagueId}/topics.json").success((data) ->
    $scope.topics = data.topics
    $scope.leagueId = data.league.id
    LeagueService.setLeague(data.league)
  )

]
