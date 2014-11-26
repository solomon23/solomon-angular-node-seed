# setup the app
appModule = angular.module("myApp", [
    "ngRoute"
    "ngResource"
    "ngCookies"
    "classy"
]).config ["$locationProvider", ($locationProvider) ->
    # add app config here
    $locationProvider.html5Mode(true).hashPrefix "!"

    # using fastclick here to avoid the 300ms delay when clicking items
    # this is a known issue that ngTouch is meant to solve but does not
    # https://github.com/angular/angular.js/issues/2548
    $ -> FastClick.attach document.body
]