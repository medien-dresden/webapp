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
    JUnitXmlReporter = require('jasmine-reporters').JUnitXmlReporter
    browser.getCapabilities()
      .then (caps) ->
        jasmine.getEnv().addReporter(
          new JUnitXmlReporter '../reports', true, true, "#{caps.caps_.browserName}-v#{caps.caps_.version}")
