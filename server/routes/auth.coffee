_    = require "underscore"
hash = require "../utils/hash"

# user database
users = [{
    id: 1
    login: "test"
    hash: "zjMq4vRIjQC4hcmk4cUOVqlLNYDVHfn800AiZ8ElWaFanniWndxma5Qlyntaf6ifhHuG9XcLKwvvU0ylpZy9nZ1cme5uAmABkU/FiMs1zJGLpPqrpteMcoFT6+cnX4PhvDzaeUfB9iAgfQOVgE/obJ48zQmOWQqheUatKu4JFv4="
    salt: "dOfXeSMI69X3on2eNlolWLaWGDAf4/obx8SFnF4UBhiIZDkRPzHoDoC6Yy6xIkY7Igi+Y3hmmhB9ccEYw2BXDWhp3UZjlx4gBOvCu0KPNtigjhsK1O414qyxNHAURGyKhjNuqA6Tyfvlx7a2Fcy2RL2pjl6M1umiDR2RTfXn1OY="
}]

# verify the userlogin and pass by checking the hash
authenticate = (login, pass, cb) ->
    user = _.findWhere users, login: login
    return cb new Error "cannot find user" unless user

    userHash = hash.getHashForSalt pass, user.salt, (err, hash) ->
        return cb err if err

        if hash is user.hash
            cb null, user
        else
            cb new Error "Invalid password"

module.exports =
  login: (req, res) ->
        authenticate req.body.login, req.body.pass, (err, user) ->
            if err or !user
                req.session = null
                res.json 404, message: "user not found"
                return

            # put the user in the session
            req.session.user = login: user.login, id: user.id
            res.json 200, message: "success", login: user.login, id: user.id