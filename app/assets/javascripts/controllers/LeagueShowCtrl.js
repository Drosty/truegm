this.truegm.controller('LeagueShowCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$http.get("./leagues/" + $routeParams.id + ".json").success(function(data) {
			$scope.league = data;
			return LeagueService.setLeague($scope.league);
		});

		$scope.viewLeagues = function() {
			return $location.path("/leagues/");
		};

		$scope.viewTeam = function(teamId) {
			return $location.path("/league/" + $scope.league.id + "/team/" + teamId);
		};

		$scope.viewUser = function(userId) {
			return $location.path("/user/" + userId);
		};
	}
]);
