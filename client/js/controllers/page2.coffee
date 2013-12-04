define ["appModule"], (appModule) ->
    
    Page2Controller = ($scope, remote) ->
        $scope.page = "page2"

        # this will fire an api request on page load
        # this returns an object that will update itself once the data
        # is ready so it can be used directly in the page
        $scope.myData = remote.resourceRequest().get()
        
        # myData will be $resolved when the data is ready
        $scope.$watch "myData.$resolved", (val) ->
            # mark the page as complete
            $scope.pageDone() if val

    # register the controller
    appModule.controller "Page2Controller", [
        "$scope"
        "remote"
        Page2Controller
    ]