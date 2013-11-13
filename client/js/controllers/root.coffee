define ["appModule", "templates"], (appModule) ->
    
    RootController = ($scope, $route, $location) ->
        _init = ->
            $scope.location = $location

        _init()

    # register the controller
    appModule.controller "rootController", [
        "$scope" 
        "$route"
        "$location"
        RootController
    ]