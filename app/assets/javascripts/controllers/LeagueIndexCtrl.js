this.truegm.controller('LeagueIndexCtrl', [
	'$scope', '$location', '$http', 'LeagueService',
	function($scope, $location, $http, LeagueService) {
		$scope.leagues = [];
		LeagueService.clearLeague();

		$http.get('./leagues.json').success(function(data) {
			return $scope.leagues = data.leagues;
		});

		$scope.viewLeague = function(id) {
			return $location.path("/league/" + id);
		};
	}
]);
