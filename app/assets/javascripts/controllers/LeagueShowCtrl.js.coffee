@truegm.controller 'LeagueShowCtrl', ['$scope', '$location', '$http', '$routeParams', ($scope, $location, $http, $routeParams) ->
  $http.get("./leagues/#{$routeParams.id}.json").success((data) ->
    $scope.league = data
  )

  # Add the following lines
  $scope.viewLeagues = ->
    $location.url "/leagues/"
]
