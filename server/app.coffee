express      = require "express"
http         = require "http"
path         = require "path"
routes       = require "./routes"
jsonsecurity = require "./middleware/jsonsecurity"

app = express()
cwd = process.cwd()

app.configure ->
    app.set "port", process.env.PORT || 3000
    app.set "views", __dirname + "/views"
    app.set "view engine", "ejs"
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.cookieSession
        secret: (process.env.EXPRESS_COOKIE_PASSPHRASE or "todo")
        cookie:
            maxAge: 60 * 60 * 1000 * 8
            httpOnly: false
    app.use express.compress()
    app.use jsonsecurity.munge

    if process.env.NODE_ENV isnt "production"
        # used to grab the coffee and map files
        app.use express.static path.join cwd, "client"

    # stores the css and image files
    app.use express.static path.join cwd, "public"

    # putting the logger after the static will only log the api requests
    if process.env.NODE_ENV is "production"
        app.use express.logger()

    # route is last to allow static files to be picked up
    app.use app.router

app.configure "development", ->
    app.use express.errorHandler()

# setup the routes
routes.set app

http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get "port"