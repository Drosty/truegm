this.truegm.controller('TopicNewCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.form = {};
		$scope.form.name = "";
		$scope.form.description = "";
		$scope.leagueId = $routeParams.leagueId;
		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);
		$scope.errorMessage = "";

		$scope.formSubmit = function() {
			var dataObj;
			$scope.errorMessage = "";
			dataObj = {
				name: this.form.name,
				description: this.form.description
			};
			$http.post("./leagues/" + $scope.leagueId + "/topics/", dataObj).success(
				function(data) {
					if (data.success) {
						return $location.path("/league/" + $scope.leagueId + "/topics/" +
							data.topic.id);
					} else {
						return $scope.errorMessage =
							"There was a problem saving topic.  Try again.";
					}
				});
		};
	}
]);
