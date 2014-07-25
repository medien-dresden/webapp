app = angular.module 'app', []

app.controller 'AppCtrl', ($scope) ->
  $scope.greeting = 'Hi there!'

  $scope.ringDoorBell = ->
    $scope.greeting = 'Beat it!'
