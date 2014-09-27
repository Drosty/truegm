@truegm.controller 'PlayerIndexCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $scope.form = {}
  $scope.form.positionSearch = ""
  $scope.form.availabilitySearch = ""
  $scope.form.page = ""
  $scope.form.perPage = ""
  $scope.form.searchString = ""
  $scope.form.isOpen = false
  $scope.form.totalPlayersCount = "0"

  $scope.playerStatuses = ["Free Agent", "Owned", "All"]
  $scope.positions = ["ALL", "QB", "RB", "WR", "TE", "RB/WR/TE", "K", "DEF"]
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
    $scope.form.totalPlayersCount = data.totalPlayers
    return

  $scope.refreshData = ->
    dataObj = {
      page: this.form.page
      position: this.form.positionSearch
      own_status: this.form.availabilitySearch
      player_name: this.form.searchString
    }

    $http.get("./leagues/#{$routeParams.leagueId}/player.json", params: dataObj).success((data) ->
      $scope.updateInformation(data)
      $scope.form.isOpen = false
    )
    return

  $scope.formClear = ->
    this.form.page = 1
    this.form.positionSearch = "All"
    this.form.availabilitySearch = "Free Agent"
    this.form.searchString = ""
    $scope.refreshData()
    return

]
