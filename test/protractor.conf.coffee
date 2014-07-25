exports.config =
  allScriptsTimeout: 1100

  baseUrl: 'http://localhost:8080/'

  framework: 'jasmine'

  specs: [
    'e2e/**/*.spec.coffee'
  ]

  capabilities:
    browserName: 'firefox'

  jasmineNodeOpts:
    defaultTimeoutInterval: 30000

  onPrepare: ->
    reporter = require('jasmine-reporters')
    browser.getCapabilities().then (caps) ->
      jasmine.getEnv().addReporter new reporter.JUnitXmlReporter
        filePrefix: "#{caps.caps_.browserName}-v#{caps.caps_.version}"
        savePath: '../reports/e2e'
