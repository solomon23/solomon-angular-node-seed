# add the service
appModule.service "auth", ["$http", "$resource", "$cookieStore",

    class
        constructor: (@$http, @$resource, @$cookieStore) ->
            @user = globals.user

        isAuthed: -> @user?

        login: (login, pass) ->
            @user = null
            @$http.post("/api/login", login: login, pass:pass)
                .success (res) =>
                    @user =
                        login: res.login
                        id: res.id

        logout: ->
            @user = null
            @$cookieStore.remove "connect.sess"
]