# register the controller
appModule.classy.controller
    name: "AdminController"
    inject: ["$scope", "$log", "$location", "auth", "remote"]
    init: ->
        @remote.secureGet()
            .success (res) =>
                @$.secureData = res.message

    logout: ->
        @auth.logout()
        @$location.path "/login"
