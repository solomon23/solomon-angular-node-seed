# add the service
appModule.service "auth", ["$http", "$resource",

    class
        constructor: (@$http, @$resource) ->
            @user = globals.user

        isAuthed: -> @user?

        login: (login, pass) ->
            @user = null
            @$http.post("/api/login", login: login, pass:pass)
                .success (res) =>
                    @user =
                        login: res.login
                        id: res.id
]