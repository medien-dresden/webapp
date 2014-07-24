exports.config = (config) ->
  config.set
    frameworks: 'jasmine'

    allScriptsTimeout: 1100

    seleniumAddress: 'http://localhost:4444/wd/hub'
    baseUrl: 'http://localhost:8080/'

    framework: 'jasmine',

    specs: ['test/e2e/**/*.spec.coffee']

    capabilities:
      'browserName': 'firefox'

    jasmineNodeOpts:
      defaultTimeoutInterval: 30000
