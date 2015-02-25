this.truegm.controller('PlayerShowCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService', '$aside',
	function($scope, $location, $http, $routeParams, LeagueService, $aside) {
		$scope.currentLeagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);
		$http.get("./leagues/" + $routeParams.leagueId + "/player/" + $routeParams.id +
			".json").success(function(data) {
			$scope.player = data;
			return $scope.stats = data.stats;
		});

		$scope.openAddPlayerAside = function(){
			$aside.open({
				templateUrl: 'player/addPlayerMenu.html',
				placement: 'bottom',
				size: 'sm',
				backdrop: true,
				resolve: {
					player: function () {
						return $scope.player;
					}
				},
				controller: function($scope, $modalInstance, player, LeagueService) {
					$scope.playerToAdd = player;

					$scope.close = function(e) {
						$modalInstance.close();
						e.stopPropagation();
					};

					$scope.addPlayer = function() {
						var dataObj;
						dataObj = {};
						$http.post("./leagues/" + LeagueService.currentLeague().id + "/player/" + $scope.playerToAdd.id + "/add_player", {
							params: dataObj
						}).success(function(data) {
							return $location.path("/league/" + LeagueService.currentLeague().id);
						});

						$modalInstance.close();
					};

					$scope.replacePlayer = function(removePlayerId){
						console.log("Will add playerID: " + $scope.playerToAdd.id + " remove: " + removePlayerId);
						$modalInstance.close();
					};
				}
			})
		};

		$scope.openRemovePlayerAside = function(){
			$aside.open({
				templateUrl: 'player/removePlayerMenu.html',
				placement: 'bottom',
				size: 'sm',
				backdrop: true,
				resolve: {
					player: function () {
						return $scope.player;
					}
				},
				controller: function($scope, $modalInstance, player, LeagueService) {
					$scope.playerToRemove = player;

					$scope.close = function(e) {
						$modalInstance.close();
						e.stopPropagation();
					};

					$scope.removePlayer = function() {
						var dataObj;
						dataObj = {};
						$http.post("./leagues/" + LeagueService.currentLeague().id + "/player/" +
							$scope.playerToRemove.id + "/remove_player", {
								params: dataObj
							}).success(function(data) {
							return $location.path("/league/" + LeagueService.currentLeague().id);
						});

						$modalInstance.close();
					};
				}
			})
		};
	}
]);
