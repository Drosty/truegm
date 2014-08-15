@truegm.controller 'PlayerShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./teams/#{$routeParams.id}.json").success((data) ->
    $scope.team = data
    LeagueService.setLeague($scope.team.league)
  )

]
