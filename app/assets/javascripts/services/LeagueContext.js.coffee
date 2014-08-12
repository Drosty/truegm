truegm.factory "LeagueService", ->
  currentLeague = null

  setLeague: (league) ->
    console.log("setting league to " + league.name)
    currentLeague = league

  clearLeague: ->
    console.log("clearing league")
    currentLeague = undefined

  currentLeague: ->
    currentLeague
