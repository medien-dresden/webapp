page = require '../home/home.page'

describe 'home', ->

  beforeEach -> page.go()

  it 'becomes angry if you ring the bell', ->
    expect(page.greeting).toBe 'Hi there!'
    page.doorBell.click()
    expect(page.greeting).toBe 'Beat it!'
