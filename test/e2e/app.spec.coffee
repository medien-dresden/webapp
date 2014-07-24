describe 'app', ->

  browser.get '/'

  it 'will load anything', ->
    expect(browser.getLocationAbsUrl()).toMatch '/'
