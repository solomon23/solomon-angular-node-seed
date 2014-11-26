# register the controller
appModule.classy.controller
    name: "LoginController"
    inject: ["$scope", "$log", "$location", "remote", "auth"]
    init: ->
        return @$location.path("/admin").replace() if @auth.user

    login: ->
        @auth.login(@$.user.name, @$.user.pass)
            .success =>
                @$location.path("/admin").replace()

            .error =>
                @$.error = true