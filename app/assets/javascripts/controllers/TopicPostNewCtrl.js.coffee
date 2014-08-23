@truegm.controller 'TopicPostNewCtrl', ['$scope', '$location', '$http', '$routeParams', 'LeagueService', ($scope, $location, $http, $routeParams, LeagueService) ->

  $scope.form = {}
  $scope.form.forum_post = ""

  $scope.leagueId = $routeParams.leagueId
  $scope.topicId = $routeParams.topicId

  LeagueService.setOrUpdateLeagueById($routeParams.leagueId)

  $scope.errorMessage = ""

  $scope.formSubmit = ->
    $scope.errorMessage = ""
    dataObj = {
      forum_post: this.form.postBody
    }

    $http.post("./leagues/#{$scope.leagueId}/topics/#{$scope.topicId}/forum_posts", dataObj).success((data) ->
      if data.success
        $location.path "/league/#{$scope.leagueId}/topics/#{$scope.topicId}"
      else
        $scope.errorMessage = "There was a problem saving post.  Try again."
    )
    return

]
