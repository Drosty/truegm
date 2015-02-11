this.truegm.controller('TopNavigationCtrl', [
	'$scope', '$location', 'LeagueService',
	function($scope, $location, LeagueService) {
		$scope.$watch(LeagueService.currentLeague, function(league) {
			if (!!league) {
				$scope.leagueName = league.name;
				$scope.leagueId = league.id;
				$scope.isLeagueSelected = true;
				$scope.teams = league.teams;
				$scope.currentTeamId = league.currentTeamId;
			} else {
				$scope.leagueName = 'TrueGm';
				$scope.leagueId = 0;
				$scope.isLeagueSelected = false;
				$scope.teams = null;
				$scope.currentTeamId = null;
			}
		});

		$scope.showMyTeam = function() {
			return $location.path("/league/" + $scope.leagueId + "/team/" + $scope.currentTeamId);
		};

		$scope.viewLeagues = function() {
			return $location.path("/leagues/");
		};

		$scope.showForum = function() {
			return $location.path("/league/" + $scope.leagueId + "/topics");
		};

		$scope.showPlayers = function() {
			return $location.path("/league/" + $scope.leagueId + "/players");
		};

		$scope.showSchedule = function() {
			return $location.path("/league/" + $scope.leagueId + "/schedule");
		};

		$scope.showTeam = function(teamId) {
			return $location.path("/league/" + $scope.leagueId + "/team/" + teamId);
		};

		$scope.showActivity = function() {
			return $location.path("/league/" + $scope.leagueId + "/activity");
		};
	}
]);
