define ["appModule"], (appModule) ->
    
    Page2Controller = ($scope, remote) ->
        $scope.page = "page2"

        # this will fire an api request on page load
        remote.resourceRequest().get (data) ->
            $scope.myData = data.message            

            # mark the page as complete
            $scope.pageDone()

    # register the controller
    appModule.controller "Page2Controller", [
        "$scope"
        "remote"
        Page2Controller
    ]