@truegm.controller 'PlayerShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $scope.currentLeagueId = $routeParams.leagueId
  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $http.get("./leagues/#{$routeParams.leagueId}/player/#{$routeParams.id}.json").success((data) ->
    $scope.player = data
    $scope.stats = data.stats
  )

]
