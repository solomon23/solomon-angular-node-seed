define ["angular"], (angular) ->

    # setup the app
    angular.module("myApp", [
        "ngRoute"
    ]).
    config ["$routeProvider", ($routeProvider) ->
        # add app config here
    ]