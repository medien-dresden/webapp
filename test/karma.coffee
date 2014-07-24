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

    frameworks: ['jasmine']
    browsers: ['PhantomJS']
    reporters: ['progress']

  return this
