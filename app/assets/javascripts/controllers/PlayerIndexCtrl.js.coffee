@truegm.controller 'PlayerIndexCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $scope.form = {}
  $scope.form.positionSearch = ""
  $scope.form.availabilitySearch = ""
  $scope.form.page = ""
  $scope.form.perPage = ""

  $scope.playerStatuses = {"Free Agents", "Owned", "All Players"}
  $scope.positions = {"ALL", "QB", "RB", "WR", "TE", "RB/WR/TE", "PK", "D"}
  $scope.currentLeagueId = $routeParams.leagueId
  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $http.get("./leagues/#{$routeParams.leagueId}/player.json").success((data) ->
    $scope.players = data.players
  )

]
