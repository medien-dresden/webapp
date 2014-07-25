describe 'app', ->

  beforeEach ->
    browser.get 'index.html'

  it 'will load anything', ->
    expect(browser.getLocationAbsUrl()).toMatch '/'
