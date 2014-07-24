module.exports = (config) ->
  config.set
    basePath: '../'

    singleRun: true

    files: [
      '.build/vendor/**/*.js'
      'node_modules/angular-mocks/angular-mocks.js'
      'src/**/*.coffee'
      'test/unit/**/*.spec.coffee'
    ]

    reporters: [
      'dots'
      'junit'
      'coverage'
    ]

    frameworks: ['jasmine']
    browsers: ['PhantomJS']

    preprocessors:
      'src/**/*.coffee': 'coverage'
      'test/unit/**/*.coffee': 'coffee'

    junitReporter:
      outputFile: 'reports/unit.xml'
      suite: 'unit'

    coverageReporter:
      type: 'lcov'
      dir: 'reports/coverage'