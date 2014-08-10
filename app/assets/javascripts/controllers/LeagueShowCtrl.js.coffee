@truegm.controller 'LeagueShowCtrl', ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
  $http.get("./leagues/#{$routeParams.id}.json").success((data) ->
    $scope.league = data
  )
]
