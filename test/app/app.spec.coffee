describe 'app', ->

  beforeEach module 'app'

  describe 'controller', ->

    describe 'AppCtrl', ->

      beforeEach inject ($rootScope, $controller) =>
        $controller 'AppCtrl', $scope: @scope = $rootScope.$new()

      it 'has no "stuff" in its scope', =>
        expect(@scope.stuff).toBeUndefined()

      it 'has "yeah" in its scope', =>
        expect(@scope.yeah).toBe 'Yeah!'
