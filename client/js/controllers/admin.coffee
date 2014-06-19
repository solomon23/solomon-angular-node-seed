# register the controller
appModule.controller "AdminController", [
    "$scope", "$log", "$location", "auth", "remote"
    ($scope, $log, $location, auth, remote) ->
        _init = ->
            remote.secureGet()
                .success (res) ->
                    $scope.secureData = res.message

        $scope.logout = ->
            auth.logout()
            $location.path "/login"

        _init()
]