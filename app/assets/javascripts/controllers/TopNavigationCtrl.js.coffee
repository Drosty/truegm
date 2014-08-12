@truegm.controller 'TopNavigationCtrl', ['$scope', '$location', 'LeagueService', ($scope, $location, LeagueService) ->

  $scope.$watch LeagueService.currentLeague, (league) ->
    $scope.isLeagueSelected = !!league
    if !!league
      $scope.leagueName = league.name
    else
      $scope.leagueName = ''

    return

  # Add the following lines
  $scope.viewLeagues = ->
    $location.url "/leagues/"
]
