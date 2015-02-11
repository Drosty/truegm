this.truegm.controller('TopicIndexCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.leagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);
		$http.get("./leagues/" + $routeParams.leagueId + "/topics.json").success(
			function(data) {
				return $scope.topics = data.topics;
			});
	}
]);
