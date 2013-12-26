_ = require "underscore"

# shared
config = 
    cdn: ""

# client specific
client = 
    env: "client prod"

# server specific
server =
    env: "server prod"

if process.env.BUILD_ENV is "client"
    _.extend config, client
else
    _.extend config, server

module.exports = config