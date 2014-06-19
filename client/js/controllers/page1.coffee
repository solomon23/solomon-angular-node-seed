# register the controller
appModule.controller "Page1Controller", [
    "$scope", "$log", "remote", "remoteData"
    ($scope, $log, remote, remoteData) ->
        _init = ->
            $scope.page = "page1"

            # this data is retrieved by the route and blocks page loading until it's ready
            $scope.myData = remoteData.message


            remote.secureGet()
                .success (res) ->
                    $scope.secureData = res.message

                .error (res) ->
                    $scope.errorData = "unable to get secure data.  login!"

                .finally ->
                    $scope.pageDone()

        _init()
]