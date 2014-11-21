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
  h.project.compile(Roots, fixture_name, done)

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
    h.file.contains(p, ['doge', 'manatoge', 'fuzzy', 'cowlike'])

describe 'custom directory', ->
  before (done) -> compile_fixture.call(@, 'custom_dir', -> done())

  it "loads data from a custom directory", ->
    p = path.join(@public, 'index.html')
    h.file.contains(p, ['doge', 'manatoge', 'fuzzy', 'cowlike'])
