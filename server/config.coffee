_ = require "underscore"

config = 
    cdn: ""

prod = 
    cdn: ""

if process.env.NODE_ENV is "production"
    _.extend config, prod

exports.get = ->
    config