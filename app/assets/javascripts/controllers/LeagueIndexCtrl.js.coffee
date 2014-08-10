@truegm.controller 'LeagueIndexCtrl', ['$scope', '$location', '$http', ($scope, $location, $http) ->
  $scope.leagues = []
  $http.get('./leagues.json').success((data) ->
    $scope.leagues = data
  )

  # Add the following lines
  $scope.viewLeague = (id) ->
    $location.url "/league/#{id}"
]
