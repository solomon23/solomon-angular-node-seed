phantom = require "../utils/phantom"
config  = require("../config").get()

exports.do = (req, res, next) ->

    fragment = req.query["_escaped_fragment_"]
    ua       = req.get "user-agent"
    host     = req.get "host"
    handle   = (err, content) -> res.send content

    isBot = false
    config.bots.forEach (i) ->
        if ua.match i
            isBot = true
            return false

    # ignore phantom requests
    if ua.match /PhantomJS/i
        next()

    # handle fragments
    else if fragment
        url = "#{req.protocol}://#{host}/#!#{fragment}" 
        phantom.get url, handle

    # handle bots
    else if isBot
        url = "#{req.protocol}://#{host}#{req.url}"
        phantom.get url, handle

    # normal request
    else    
        next()