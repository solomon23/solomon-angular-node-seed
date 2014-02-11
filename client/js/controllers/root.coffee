define ["appModule", "underscore", "templates"], (appModule, _) ->
    appModule.controller "rootController", ($scope, $route, $location, $timeout, $window) ->
        _init = ->
            $scope.location = $location

        ###
            Call this method when the page is done making external requests.  This tells the phantom
            browser to go ahead and collect the HTML up for SEO.
        ###
        $scope.pageDone = ->
            # collect after the render cycle is complete
            $timeout ->
                $window.callPhantom() if _.isFunction $window.callPhantom

        _init()