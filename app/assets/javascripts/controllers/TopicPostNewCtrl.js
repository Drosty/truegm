this.truegm.controller('TopicPostNewCtrl', [
	'$scope', '$location', '$http', '$routeParams', 'LeagueService',
	function($scope, $location, $http, $routeParams, LeagueService) {
		$scope.form = {};
		$scope.form.forum_post = "";
		$scope.leagueId = $routeParams.leagueId;
		$scope.topicId = $routeParams.topicId;
		$scope.errorMessage = "";

		LeagueService.setOrUpdateLeagueById($routeParams.leagueId);

		$scope.formSubmit = function() {
			var dataObj;
			$scope.errorMessage = "";
			dataObj = {
				forum_post: this.form.postBody
			};
			$http.post("./leagues/" + $scope.leagueId + "/topics/" + $scope.topicId +
				"/forum_posts", dataObj).success(function(data) {
				if (data.success) {
					return $location.path("/league/" + $scope.leagueId + "/topics/" +
						$scope.topicId);
				} else {
					return $scope.errorMessage =
						"There was a problem saving post.  Try again.";
				}
			});
		};
	}
]);
