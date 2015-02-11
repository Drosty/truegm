this.truegm.controller('ActivityIndexCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.currentLeagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);

		$http.get('./leagues/' + $scope.currentLeagueId + '/activity.json').success(
			function(data) {
				return $scope.activities = data.activities;
			});
	}
]);
