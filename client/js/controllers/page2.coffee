define ["appModule"], (appModule) ->
    
    Page2Controller = ($scope) ->
        $scope.page = "page2"


        # mark the page as complete
        $scope.pageDone()

    # register the controller
    appModule.controller "Page2Controller", [
        "$scope"
        Page2Controller
    ]