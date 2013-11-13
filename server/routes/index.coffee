data  = require "./data"
pages = require "./pages"

exports.set = (app) ->
    
    # setup all the routes
    app.get "/",            pages.index
    app.get "/getdata",     data.get