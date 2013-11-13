phantom = require "../utils/phantom"

exports.checkBot = (req, res, next) ->
    fragment = req.query["_escaped_fragment_"]

    if fragment
        host = req.get "host"
        url = "http://#{host}/#!#{fragment}"

        handle = (err, content) ->            
            res.send content

        phantom.get url, handle
    else    
        next()