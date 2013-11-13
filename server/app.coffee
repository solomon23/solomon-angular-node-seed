express = require "express"
http    = require "http"
path    = require "path"
routes  = require "./routes"

app = express()
cwd = process.cwd()

app.configure ->
    app.set "port", process.env.PORT || 3000
    app.set "views", __dirname + "/views"
    app.set "view engine", "ejs"
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use express.compress()

    if process.env.NODE_ENV isnt "production"
        # used to grab the coffee and map files
        app.use express.static path.join cwd, "client"

    # stores the css and image files
    app.use express.static path.join cwd, "public"

app.configure "development", ->
    app.use express.errorHandler()

# setup the routes
routes.set app

http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get "port"