exports.config =
  allScriptsTimeout: 1100

  baseUrl: 'http://localhost:8080/'

  framework: 'jasmine'

  specs: [
    'e2e/**/*.spec.coffee'
  ]

  capabilities:
    'browserName': 'firefox'

  jasmineNodeOpts:
    defaultTimeoutInterval: 30000
