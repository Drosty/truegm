@truegm.controller 'ActivityIndexCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->
  $scope.currentLeagueId = $routeParams.leagueId
  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $http.get('./leagues/' + $scope.currentLeagueId + '/activity.json').success((data) ->
    $scope.activities = data.activities
  )

]
