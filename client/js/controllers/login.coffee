# register the controller
appModule.controller "LoginController", [
    "$scope", "$log", "$location", "remote", "auth"
    ($scope, $log, $location, remote, auth) ->

        _init = ->
            return $location.path("/admin").replace() if auth.user

        $scope.login = ->
            auth.login($scope.user.name, $scope.user.pass)
                .success ->
                    $location.path("/admin").replace()

                .error -> $scope.error = true

        _init()
]