crypto = require "crypto"

#
# Bytesize.
#

LEN = 128

#
# ITERATIONS. ~15ms
#

ITERATIONS = 600

module.exports =

    # returns a hash and salt for a given password
    getHashAndSalt: (pwd, cb) ->
        crypto.randomBytes LEN, (err, salt) ->
            return cb(err) if err

            salt = salt.toString "base64"

            crypto.pbkdf2 pwd, salt, ITERATIONS, LEN, (err, hash) ->
                return cb(err) if err
                cb null, salt, hash.toString "base64"

    # returns a hash for a given password and salt
    getHashForSalt: (pwd, salt, cb) ->
        crypto.pbkdf2 pwd, salt, ITERATIONS, LEN, (err, hash) ->
            cb err, hash?.toString "base64"
