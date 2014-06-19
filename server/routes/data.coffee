module.exports =
    get: (req, res) ->
        res.json message: "You Got Data"

    getsecure: (req, res) ->
        res.json message: "I'm secure data"