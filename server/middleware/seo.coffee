phantom = require "../utils/phantom"

exports.do = (req, res, next) ->

    fragment = req.query["_escaped_fragment_"]
    ua       = req.get "user-agent"
    host     = req.get "host"
    handle   = (err, content) -> res.send content

    # ignore phantom requests
    if ua.match /PhantomJS/i
        next()

    # handle fragments
    else if fragment
        url = "http://#{host}/#!#{fragment}" 
        phantom.get url, handle

    # handle bots
    else if ua.match /facebook/i
        url = "#{req.protocol}://#{host}#{req.url}"
        phantom.get url, handle

    # normal request
    else    
        next()