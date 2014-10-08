@daily.controller 'DailyGamesIndexCtrl', ['$scope', '$location', '$http', ($scope, $location, $http) ->
  $scope.qbs  = []
  $scope.rbs  = []
  $scope.wrs  = []
  $scope.tes  = []
  $scope.ks   = []
  $scope.dsts = []
  $scope.week = 1

  $scope.optimized_lineup_message = "Click Submit to Get Optimized Linup"
  $scope.showOptimizedLineup = false

  $scope.optimized_qb   = null
  $scope.optimized_rb_1 = null
  $scope.optimized_rb_2 = null
  $scope.optimized_wr_1 = null
  $scope.optimized_wr_2 = null
  $scope.optimized_wr_3 = null
  $scope.optimized_te   = null
  $scope.optimized_k    = null
  $scope.optimized_d    = null
  $scope.optimized_projection = 0

  $http.get('./dailyinfo.json').success((data) ->
    $scope.week = data.week
    $scope.qbs  = data.qbs
    $scope.rbs  = data.rbs
    $scope.wrs  = data.wrs
    $scope.tes  = data.tes
    $scope.ks   = data.ks
    $scope.dsts = data.dsts
  )

  $scope.qbClicked = (data) ->
    $scope.qbs.forEach (d, i) ->
      d.status = (d.status + 1) % 3 if d.id == data
      return
    return

  $scope.rbClicked = (data) ->
    $scope.rbs.forEach (d, i) ->
      d.status = (d.status + 1) % 3 if d.id == data
      return
    return

  $scope.wrClicked = (data) ->
    $scope.wrs.forEach (d, i) ->
      d.status = (d.status + 1) % 3 if d.id == data
      return
    return

  $scope.teClicked = (data) ->
    $scope.tes.forEach (d, i) ->
      d.status = (d.status + 1) % 3 if d.id == data
      return
    return

  $scope.kClicked = (data) ->
    $scope.ks.forEach (d, i) ->
      d.status = (d.status + 1) % 3 if d.id == data
      return
    return

  $scope.dClicked = (data) ->
    $scope.dsts.forEach (d, i) ->
      d.status = (d.status + 1) % 3 if d.id == data
      return
    return

  $scope.playerClass = (status) ->
    if status == 0
      return "btn btn-default btn-xs"
    if status == 1
      return "btn btn-success btn-xs"
    if status == 2
      return "btn btn-danger btn-xs"

    return ""

  $scope.clearOptimizedLineup = () ->
    $scope.optimized_qb   = null
    $scope.optimized_rb_1 = null
    $scope.optimized_rb_2 = null
    $scope.optimized_wr_1 = null
    $scope.optimized_wr_2 = null
    $scope.optimized_wr_3 = null
    $scope.optimized_te   = null
    $scope.optimized_k    = null
    $scope.optimized_d    = null
    $scope.showOptimizedLineup = false
    return

  $scope.getAllowedPlayerIds = (array) ->
    return array.filter((x) ->
      x.status is 1
    ).map((x) ->
      x.id
    )

  $scope.getRejectedPlayerIds = (array) ->
    return array.filter((x) ->
      x.status is 2
    ).map((x) ->
      x.id
    )

  $scope.getOptimizedLineup = () ->
    $scope.clearOptimizedLineup()
    $scope.optimized_lineup_message = "Getting Lineup, please wait"

    dataObj = {
      qbs_allowed: $scope.getAllowedPlayerIds($scope.qbs)
      qbs_reject:  $scope.getRejectedPlayerIds($scope.qbs)
      rbs_allowed: $scope.getAllowedPlayerIds($scope.rbs)
      rbs_reject:  $scope.getRejectedPlayerIds($scope.rbs)
      wrs_allowed:  $scope.getAllowedPlayerIds($scope.wrs)
      wrs_reject:  $scope.getRejectedPlayerIds($scope.wrs)
      tes_allowed: $scope.getAllowedPlayerIds($scope.tes)
      tes_reject:  $scope.getRejectedPlayerIds($scope.tes)
      ks_allowed: $scope.getAllowedPlayerIds($scope.ks)
      ks_reject:  $scope.getRejectedPlayerIds($scope.ks)
      dsts_allowed: $scope.getAllowedPlayerIds($scope.dsts)
      dsts_reject:  $scope.getRejectedPlayerIds($scope.dsts)
    }

    $http.post("./daily/", dataObj).success((data) ->
      $scope.optimized_lineup_message = ""
      $scope.optimized_projection = data.projection
      $scope.optimized_qb   = data.qb
      $scope.optimized_rb_1 = data.rb1
      $scope.optimized_rb_2 = data.rb2
      $scope.optimized_wr_1 = data.wr1
      $scope.optimized_wr_2 = data.wr2
      $scope.optimized_wr_3 = data.wr3
      $scope.optimized_te   = data.te
      $scope.optimized_k    = data.k
      $scope.optimized_d    = data.dst
      $scope.showOptimizedLineup = true
      return
    ).error((data) ->
      $scope.optimized_lineup_message = "shit errored"
      return
    )
    return

]
