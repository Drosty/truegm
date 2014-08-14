@truegm.controller 'LeagueShowCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $http.get("./leagues/#{$routeParams.id}.json").success((data) ->
    $scope.league = data
    LeagueService.setLeague($scope.league)
  )

  # Add the following lines
  $scope.viewLeagues = ->
    $location.path "/leagues/"

  $scope.viewTeam = (teamId) ->
    $location.path "/team/" + teamId

  $scope.viewUser = (userId) ->
    $location.path "/user/" + userId
]
