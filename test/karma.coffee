module.exports = (config) ->
  config.set
    basePath: '../'

    singleRun: true

    files: [
      '.build/vendor/**/*.js'
      'node_modules/angular-mocks/angular-mocks.js'
      '.build/src/**/*.js'
      '.build/test/**/*.js'
    ]

    reporters: [
      'dots'
      'junit'
      'coverage'
    ]

    frameworks: ['jasmine']
    browsers: ['PhantomJS']

    preprocessors:
      '.build/src/**/*.js': 'coverage'

    junitReporter:
      outputFile: 'reports/unit.xml'
      suite: 'unit'

    coverageReporter:
      type: 'lcov'
      dir: 'reports/coverage'