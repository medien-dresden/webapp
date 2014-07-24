describe 'app', ->

  beforeEach module 'app'

  describe 'controller', ->

    describe 'AppCtrl', ->

      beforeEach inject ($rootScope, $controller) =>
        $controller 'AppCtrl', $scope: @scope = $rootScope.$new()

      it 'is very polite', =>
        expect(@scope.greeting).toBe 'Hi there!'

      it 'is very angry if you ring the bell', =>
        @scope.doorBell()
        expect(@scope.greeting).toBe 'Beat it!'
