define ["appModule"], (appModule) ->
    
    Page2Controller = ($scope) ->
        $scope.page = "page2"


    # register the controller
    appModule.controller "Page2Controller", [
        "$scope"
        Page2Controller
    ]