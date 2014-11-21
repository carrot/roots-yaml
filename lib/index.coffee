RootsUtil = require 'roots-util'
path = require 'path'
yaml = require 'js-yaml'
minimatch = require 'minimatch'

module.exports = (opts = {}) ->
  class RootsYAML
    fs: ->
      category: 'yaml'
      ordered: true
      extract: true
      detect: (f) ->
        opts.source ?= 'data'
        minimatch(f.relative, "#{opts.source}/**/*.yaml")

    compile_hooks: ->
      before_pass: (ctx) ->
        f = ctx.file
        if f.category == 'yaml'
          locals = f.compile_options.data ?= {}
          key = path.basename(f.file.relative).replace(/.yaml$/, '')
          locals[key] = yaml.safeLoad(ctx.content)
      write: (f) -> f.category != 'yaml'
