truegm.service("LeagueService", ['$http', function($http) {
	var currentLeague;
	currentLeague = null;

	this.setLeague = function(league) {
		currentLeague = league;
	};

	this.setOrUpdateLeagueById = function(leagueId) {
		if (!currentLeague || parseInt(currentLeague.id) !== parseInt(leagueId)) {
			$http.get("./leagues/" + leagueId + ".json").success(function(data) {
				currentLeague = data;
			});
		}
	};

	this.clearLeague = function() {
		currentLeague = void 0;
	};

	this.currentLeague = function() {
		return currentLeague;
	};

}]);
