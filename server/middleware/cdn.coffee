exports.rewrite = (req, res, next) ->
    if req.url.match /static\//
        req.url = req.url.replace "static/", ""
        req.isStatic = true

    next()