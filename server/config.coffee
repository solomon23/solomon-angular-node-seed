_ = require "underscore"

config = 
    cdn: ""
    bots:[
        /googlebot/i
        /bingbot/i
        /slurp/i
        /facebookexternalhit/i
        /wget/i
        /curl/i
        /twitterbot/i
    ]

prod = 
    cdn: "http://s3.amazonaws.com/lithe-playground/public"

if process.env.NODE_ENV is "production"
    _.extend config, prod

module.exports = config