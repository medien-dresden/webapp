app = angular.module 'app', []

app.controller 'AppCtrl', ($scope) ->
  $scope.greeting = 'Hi there!'

  $scope.doorBell = ->
    $scope.greeting = 'Beat it!'
