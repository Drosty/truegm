truegm.factory "LeagueService", ['$http', ($http) ->
  currentLeague = null

  setLeague: (league) ->
    console.log("setting league to " + league.name)
    currentLeague = league

  setOrUpdateLeagueById: (leagueId) ->
    console.log("ENTER setting by id : " + leagueId)
    if(!currentLeague || currentLeague.id != leagueId)
      $http.get("./leagues/" + leagueId + ".json").success((data) ->
        currentLeague = data
      )
    return

  clearLeague: ->
    console.log("clearing league")
    currentLeague = undefined

  currentLeague: ->
    currentLeague
]
