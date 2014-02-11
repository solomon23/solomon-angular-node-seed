define ["angular", "appModule"], (angular) ->
    angular.module("myApp").controller "Page1Controller", ($scope, $log, remote, remoteData) ->
        _init = ->            
            $scope.page = "page1"

            # this data is retrieved by the route and blocks page loading until it's ready
            $scope.myData = remoteData.message

            $scope.pageDone()            

        _init()