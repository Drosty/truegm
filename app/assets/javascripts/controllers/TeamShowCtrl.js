this.truegm.controller('TeamShowCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.currentLeagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);
		$http.get("./teams/" + $routeParams.id + ".json").success(function(data) {
			return $scope.team = data;
		});
	}
]);
