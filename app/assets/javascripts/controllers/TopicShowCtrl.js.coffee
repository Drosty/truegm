@truegm.controller 'TopicShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./leagues/#{$routeParams.leagueId}/topics.json").success((data) ->
    $scope.topics = data.topics
    LeagueService.setLeague(data.league)
  )

]
