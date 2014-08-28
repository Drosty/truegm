truegm.service "LeagueService",  ['$http', ($http) ->
  currentLeague = null

  @setLeague = (league) ->
    currentLeague = league
    return

  @setOrUpdateLeagueById = (leagueId) ->
    if(!currentLeague || parseInt(currentLeague.id) != parseInt(leagueId))
      $http.get("./leagues/" + leagueId + ".json").success((data) ->
        currentLeague = data
        return
      )
    return

  @clearLeague = ->
    currentLeague = undefined
    return

  @currentLeague = ->
    currentLeague

  return
]
