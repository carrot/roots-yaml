_         = require 'lodash'
path      = require 'path'
fs        = require 'fs'
should    = require 'should'
Roots     = require 'roots'
_path     = path.join(__dirname, 'fixtures')
RootsUtil = require 'roots-util'
h = new RootsUtil.Helpers(base: _path)

# setup, teardown, and utils

compile_fixture = (fixture_name, done) ->
  @public = path.join(fixture_name, 'public')
  h.project.compile(Roots, fixture_name).then(done)

before (done) ->
  h.project.install_dependencies('*', done)

after ->
  h.project.remove_folders('**/public')

# tests

describe 'basic compile', ->

  before (done) -> compile_fixture.call(@, 'basic', -> done())

  it 'compiles basic project', ->
    p = path.join(@public, 'index.html')
    h.file.exists(p).should.be.ok

  it "doesn't write the yaml file", ->
    p = path.join(@public, 'manatoge.yaml')
    h.file.exists(p).should.not.be.ok

  it "exposes data into the view templates", ->
    p = path.join(@public, 'index.html')
    _.each ['doge', 'manatoge', 'fuzzy', 'cowlike'], (e) ->
      h.file.contains(p, e).should.be.true

  it "supports nested yaml files and sets the correct keys", ->
    p = path.join(@public, 'index.html')
    h.file.contains(p, 'fake pruett').should.be.true

describe 'custom directory', ->
  before (done) -> compile_fixture.call(@, 'custom_dir', -> done())

  it "loads data from a custom directory", ->
    p = path.join(@public, 'index.html')
    _.each ['doge', 'manatoge', 'fuzzy', 'cowlike'], (e) ->
      h.file.contains(p, e).should.be.true

describe 'view helpers', ->
  describe '#yaml', ->
    before (done) -> compile_fixture.call(@, 'view_helper', -> done())

    it "adds a script tag passing locals data to global JS var", ->
      p = path.join(@public, 'index.html')
      tag = '<script>var data = {"doge":{"wow":"such yaml"}};</script>'
      h.file.contains(p, tag).should.be.true

    it "accepts an override for the var name", ->
      p = path.join(@public, 'manatoge.html')
      tag = '<script>var manatoge = {"doge":{"wow":"such yaml"}};</script>'
      h.file.contains(p, tag).should.be.true
