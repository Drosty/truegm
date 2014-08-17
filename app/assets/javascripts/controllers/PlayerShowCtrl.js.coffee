@truegm.controller 'PlayerShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./leagues/#{$routeParams.leagueId}/player/#{$routeParams.id}.json").success((data) ->
    $scope.team = data
    LeagueService.setOrUpdateLeagueById($routeParams.leagueId)
  )

]
