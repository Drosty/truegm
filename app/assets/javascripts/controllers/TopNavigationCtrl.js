this.truegm.controller('TopNavigationCtrl', [
	'$scope', '$location', 'LeagueService', '$aside',
	function($scope, $location, LeagueService, $aside) {

		$scope.openAside = function(){
			$aside.open({
				templateUrl: 'navigation/menu.html',
				placement: 'left',
				size: 'sm',
				backdrop: true,
				controller: function($scope, $modalInstance, LeagueService) {
					$scope.isCollapsed = true;
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

					$scope.close = function(e) {
						$modalInstance.close();
						e.stopPropagation();
					};

					$scope.showMyTeam = function() {
						$modalInstance.close();
						return $location.path("/league/" + $scope.leagueId + "/team/" + $scope.currentTeamId);
					};

					$scope.viewLeagues = function() {
						$modalInstance.close();
						return $location.path("/leagues/");
					};

					$scope.showForum = function() {
						$modalInstance.close();
						return $location.path("/league/" + $scope.leagueId + "/topics");
					};

					$scope.showPlayers = function() {
						$modalInstance.close();
						return $location.path("/league/" + $scope.leagueId + "/players");
					};

					$scope.showSchedule = function() {
						$modalInstance.close();
						return $location.path("/league/" + $scope.leagueId + "/schedule");
					};

					$scope.showTeam = function(teamId) {
						$modalInstance.close();
						return $location.path("/league/" + $scope.leagueId + "/team/" + teamId);
					};

					$scope.showActivity = function() {
						$modalInstance.close();
						return $location.path("/league/" + $scope.leagueId + "/activity");
					};

					$scope.showAllLeagues = function() {
						$modalInstance.close();
						return $location.path("/leagues");
					}
				}
			});
		};
	}
]);
