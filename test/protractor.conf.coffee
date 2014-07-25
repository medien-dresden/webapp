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
    require 'jasmine-reporters'
    browser.getCapabilities().then (caps) ->
      makeDir = require 'mkdirp'
      makeDir "reports/e2e/#{caps.caps_.browserName}-v#{caps.caps_.version}/"
      jasmine.getEnv().addReporter new jasmine.JUnitXmlReporter(
        "reports/e2e/#{caps.caps_.browserName}-v#{caps.caps_.version}/", true, true, 'junit', true)
