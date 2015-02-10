this.truegm.controller('TopicShowCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.currentLeagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);
		$http.get("./leagues/" + $routeParams.leagueId + "/topics/" + $routeParams.id +
			".json").success(function(data) {
			return $scope.topic = data;
		});

		$scope.postsAvailable = function() {
			if ($scope.topic) {
				return $scope.topic.posts.length > 0;
			}
		};
	}
]);
