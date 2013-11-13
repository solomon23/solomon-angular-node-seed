data  = require "./data"
pages = require "./pages"
seo   = require "../middleware/seo"

exports.set = (app) ->
    
    # setup all the routes
    app.get "/", seo.checkBot, pages.index
    app.get "/getdata", data.get