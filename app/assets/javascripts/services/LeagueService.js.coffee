truegm.factory "LeagueService", ['$http', ($http) ->
  currentLeague = null

  setLeague: (league) ->
    currentLeague = league

  setOrUpdateLeagueById: (leagueId) ->
    if(!currentLeague || currentLeague.id != leagueId)
      $http.get("./leagues/" + leagueId + ".json").success((data) ->
        currentLeague = data
      )
    return

  clearLeague: ->
    currentLeague = undefined

  currentLeague: ->
    currentLeague
]
