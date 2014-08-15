@truegm.controller 'TeamShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./teams/#{$routeParams.id}.json").success((data) ->
    $scope.team = data
  )

]
