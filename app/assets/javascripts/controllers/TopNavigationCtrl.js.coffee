@truegm.controller 'TopNavigationCtrl', ['$scope', '$location', 'LeagueService', ($scope, $location, LeagueService) ->

  $scope.$watch LeagueService.currentLeague, (league) ->
    if !!league
      $scope.leagueName = league.name
      $scope.leagueId = league.id
      $scope.isLeagueSelected = true
      $scope.teams = league.teams
    else
      $scope.leagueName = 'TrueGm'
      $scope.leagueId = 0
      $scope.isLeagueSelected = false
      $scope.teams = null

    return

  # Add the following lines
  $scope.viewLeagues = ->
    $location.path "/leagues/"

  $scope.showForum = ->
    $location.path "/league/" + $scope.leagueId + "/topics"

  $scope.showPlayers = ->
    $location.path "/league/" + $scope.leagueId + "/players"

  $scope.showSchedule = ->
    $location.path "/league/" + $scope.leagueId + "/schedule"

  $scope.showTeam = (teamId) ->
    $location.path "/league/" + $scope.leagueId + "/team/" + teamId

  return
]