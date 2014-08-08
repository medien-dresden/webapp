module.exports = require('astrolabe').Page.create

  url: value: 'index.html'

  greeting:
    get: -> @findElement(this.by.binding 'greeting').getText()

  doorBell:
  	get: -> @findElement(this.by.css '[ng-click="ringDoorBell()"]')
