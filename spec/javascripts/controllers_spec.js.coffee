describe "TrueGM controllers", ->
  beforeEach module("truegm")

  describe "TrueGmIndexCtrl", ->
    it "should set restaurants to an empty array", inject(($controller) ->
      scope = {}
      ctrl = $controller("LeagueIndexCtrl",
        $scope: scope
      )
      expect(scope.leagues.length).toBe 0
    )
