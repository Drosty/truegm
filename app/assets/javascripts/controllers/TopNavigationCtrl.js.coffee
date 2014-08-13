@truegm.controller 'TopNavigationCtrl', ['$scope', '$location', 'LeagueService', ($scope, $location, LeagueService) ->

  $scope.$watch LeagueService.currentLeague, (league) ->
    if !!league
      $scope.leagueName = league.name
      $scope.leagueId = league.id
      $scope.isLeagueSelected = true
    else
      $scope.leagueName = 'TrueGm'
      $scope.leagueId = 0
      $scope.isLeagueSelected = false

    return

  # Add the following lines
  $scope.viewLeagues = ->
    $location.url "/leagues/"

  $scope.showForum = ->
    $location.url = "/asdf"
]
