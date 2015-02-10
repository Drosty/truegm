this.truegm.controller('PlayerShowCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.currentLeagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);
		$http.get("./leagues/" + $routeParams.leagueId + "/player/" + $routeParams.id +
			".json").success(function(data) {
			$scope.player = data;
			return $scope.stats = data.stats;
		});

		$scope.addPlayer = function() {
			var dataObj;
			dataObj = {};
			$http.post("./leagues/" + LeagueService.currentLeague().id + "/player/" +
				$scope.player.id + "/add_player", {
					params: dataObj
				}).success(function(data) {
				return $location.path("/league/" + LeagueService.currentLeague().id);
			});
		};

		$scope.removePlayer = function() {
			var dataObj;
			dataObj = {};
			$http.post("./leagues/" + LeagueService.currentLeague().id + "/player/" +
				$scope.player.id + "/remove_player", {
					params: dataObj
				}).success(function(data) {
				return $location.path("/league/" + LeagueService.currentLeague().id);
			});
		};
	}
]);
