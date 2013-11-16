data  = require "./data"
pages = require "./pages"
seo   = require "../middleware/seo"

exports.set = (app) ->
    
    # api's
    app.get "/api/getdata", data.get

    # setup all the routes
    app.get "*", seo, pages.index