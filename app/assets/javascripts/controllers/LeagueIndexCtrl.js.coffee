@truegm.controller 'LeagueIndexCtrl', ['$scope', '$location', '$http', 'LeagueService', ($scope, $location, $http, LeagueService) ->
  $scope.leagues = []
  LeagueService.clearLeague()

  $http.get('./leagues.json').success((data) ->
    $scope.leagues = data.leagues
  )

  # Add the following lines
  $scope.viewLeague = (id) ->
    $location.path "/league/#{id}"
]
