RootsUtil = require 'roots-util'
path = require 'path'
yaml = require 'js-yaml'
minimatch = require 'minimatch'

module.exports = ->
  class RootsYAML
    fs: ->
      category: 'yaml'
      ordered: true
      extract: true
      detect: (f) -> minimatch(f.relative, 'data/**/*.yaml')

    compile_hooks: ->
      before_pass: (ctx) ->
        f = ctx.file
        if f.category == 'yaml'
          locals = f.compile_options.data ?= {}
          s = path.basename(f.file.relative).split('.')
          s.pop()
          locals[s.join('.')] = yaml.safeLoad(ctx.content)
      write: (f) -> f.category != 'yaml'
