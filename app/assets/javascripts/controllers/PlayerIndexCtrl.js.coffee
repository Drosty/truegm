@truegm.controller 'PlayerIndexCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $scope.form = {}
  $scope.form.positionSearch = ""
  $scope.form.availabilitySearch = ""
  $scope.form.page = ""
  $scope.form.perPage = ""
  $scope.form.searchString = ""
  $scope.form.isOpen = false

  $scope.playerStatuses = ["Free Agent", "Owned", "All"]
  $scope.positions = ["ALL", "QB", "RB", "WR", "TE", "RB/WR/TE", "PK", "D"]
  $scope.currentLeagueId = $routeParams.leagueId
  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $http.get("./leagues/#{$routeParams.leagueId}/player.json").success((data) ->
    $scope.updateInformation(data)
    return
  )

  $scope.updateInformation = (data) ->
    $scope.players = data.players
    $scope.form.searchString = data.searchString
    $scope.form.positionSearch = data.positionSearch
    $scope.form.availabilitySearch = data.availabilitySearch
    $scope.form.page = data.page
    $scope.form.perPage = data.perPage
    return

  $scope.formSubmit = ->
    dataObj = {
      page: this.form.page
      position: this.form.positionSearch
      own_status: this.form.availabilitySearch
      player_name: this.form.searchString
    }

    $http.get("./leagues/#{$routeParams.leagueId}/player.json", params: dataObj).success((data) ->
      $scope.updateInformation(data)
      this.form.isOpen = false
    )
    return
]
