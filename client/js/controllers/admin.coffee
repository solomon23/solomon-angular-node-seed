# register the controller
appModule.controller "AdminController", [
    "$scope", "$log", "remote"
    ($scope, $log, remote) ->
        _init = ->
            remote.secureGet()
                .success (res) ->
                    $scope.secureData = res.message

        _init()
]