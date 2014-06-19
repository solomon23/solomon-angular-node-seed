data  = require "./data"
pages = require "./pages"
seo   = require "../middleware/seo"
auth  = require "./auth"

requiresAuth = (req, res, next) ->
    if req.session.user then return next()
    res.send 403, "Forbidden"

exports.set = (app) ->

    # api's
    app.get "/api/getdata", data.get

    # authenticated api
    app.get "/api/getsecuredata", requiresAuth, data.getsecure

    # authenticate
    app.post "/api/login", auth.login

    # setup all the routes
    app.get "*", seo, pages.index