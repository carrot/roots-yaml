RootsUtil = require 'roots-util'
path = require 'path'
yaml = require 'js-yaml'
_ = require 'lodash'
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
        if ctx.file.category == 'yaml' then add_yaml_to_locals.call(@, ctx)

      write: (f) -> f.category != 'yaml'

    add_yaml_to_locals = (ctx) ->
      f = ctx.file
      locals = f.compile_options.data ?= {}
      _path = path.relative(opts.source, f.file.relative).replace(/.yaml$/, '').split(path.sep)
      res = memo = {}
      for p, i in _path
        memo[p] ?= {}
        if i + 1 == _path.length then memo[p] = yaml.safeLoad(ctx.content)
        memo = memo[p]
      _.merge locals, res
