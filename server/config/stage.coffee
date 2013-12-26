_ = require "underscore"

# shared
config = 
    cdn: ""

# client specific
client = 
    env: "client stage"

# server specific
server =
    env: "server stage"

if process.env.BUILD_ENV is "client"
    _.extend config, client
else
    _.extend config, server

module.exports = config