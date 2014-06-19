_            = require "underscore"
config       = require "../config"
staticMap    = {}
staticLookup = {}

if process.env.NODE_ENV is "production"
    staticLookup = require "../assets.json"
    _.each staticLookup, (val, key) ->
        staticMap[key] = val.match(/\.\w{8}\./)[0].replace /\./g, ""

staticMap.get = (id) ->
    staticLookup[id] ? id

exports.index = (req, res, next) ->
    res.render "index", map: staticMap, env: process.env.NODE_ENV, config: config, user: req.session?.user
