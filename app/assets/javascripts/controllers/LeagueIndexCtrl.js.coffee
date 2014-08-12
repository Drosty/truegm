@truegm.controller 'LeagueIndexCtrl', ['$scope', '$location', '$http', 'LeagueService', ($scope, $location, $http, LeagueService) ->
  $scope.leagues = []
  $http.get('./leagues.json').success((data) ->
    LeagueService.clearLeague()
    $scope.leagues = data
  )

  # Add the following lines
  $scope.viewLeague = (id) ->
    $location.url "/league/#{id}"
]
