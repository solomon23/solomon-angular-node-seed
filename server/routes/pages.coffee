config    = require "../config"
staticMap = if process.env.NODE_ENV is "production" then require "../assets.json" else {}

staticMap.get = (id) ->
    staticMap[id] ? id

exports.index = (req, res, next) ->
    res.render "index", map: staticMap, env: process.env.NODE_ENV, config: config, user: req.session?.user
