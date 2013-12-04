_ = require "underscore"

ANGULAR_JSON_SECURITY_TOKEN = ")]}',\n"

exports.jsonSecurity = (req, res, next) ->    
    oldJson = res.json

    # use a custom json response that adds security for angular
    res.json = ->
        # this security solution is only needed for GET requests
        # http://haacked.com/archive/2009/06/24/json-hijacking.aspx/
        # http://docs.angularjs.org/api/ng.$http
        if req.method is "GET"
            json = if isNaN arguments[0] then arguments[0] else arguments[1]

            # this is only need for array types
            if _.isArray json
                res.set "Content-Type", "Content-Type:application/json; charset=utf-8"

                # add the security token
                json = ANGULAR_JSON_SECURITY_TOKEN + JSON.stringify json
                res.end json
            else
                oldJson.apply res, arguments
        else
            oldJson.apply res, arguments

    next()