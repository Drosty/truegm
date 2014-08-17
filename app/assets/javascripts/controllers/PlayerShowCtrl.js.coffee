@truegm.controller 'PlayerShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./leagues/#{$routeParams.leagueId}/player/#{$routeParams.id}.json").success((data) ->
    $scope.player = data
    $scope.currentLeagueId = $routeParams.leagueId
    LeagueService.setOrUpdateLeagueById($routeParams.leagueId)
  )

]
