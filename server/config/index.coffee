_     = require "underscore"
prod  = require "./prod"
stage = require "./stage"

# share config
config = 
    cdn: ""

# server specific 
server = 
    env: "server dev"
    bots:[
        /googlebot/i
        /bingbot/i
        /slurp/i
        /facebookexternalhit/i
        /wget/i
        /curl/i
        /twitterbot/i
    ]

# client specific
client = 
    env: "client dev"

# set the client or server config
if process.env.BUILD_ENV is "client"
    _.extend config, client
else
    _.extend config, server

# set the production config
if process.env.NODE_ENV is "production"
    _.extend config, prod
else if process.env.NODE_ENV is "stage"
    _.extend config, stage

module.exports = config