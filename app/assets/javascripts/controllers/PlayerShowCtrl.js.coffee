@truegm.controller 'PlayerShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $scope.currentLeagueId = $routeParams.leagueId
  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $http.get("./leagues/#{$routeParams.leagueId}/player/#{$routeParams.id}.json").success((data) ->
    $scope.player = data
    $scope.stats = data.stats
  )

  $scope.addPlayer = ()->
    dataObj = { }

    $http.post("./leagues/" + LeagueService.currentLeague().id + "/player/" + $scope.player.id + "/add_player", params: dataObj).success((data) ->
      $location.path "/league/" + LeagueService.currentLeague().id
    )
    return

  $scope.removePlayer = () ->
    dataObj = { }

    $http.post("./leagues/" + LeagueService.currentLeague().id + "/player/" + $scope.player.id + "/remove_player", params: dataObj).success((data) ->
      $location.path "/league/" + LeagueService.currentLeague().id
    )
    return
]
