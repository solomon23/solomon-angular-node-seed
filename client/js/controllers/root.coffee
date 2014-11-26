# register the controller
appModule.classy.controller
    name: "rootController"
    inject: ["$scope", "$route", "$location", "$timeout", "$window"]
    init: ->
        @$.location = @$location

    pageDone: ->
        # collect after the render cycle is complete
        @$timeout =>
            @$window.callPhantom() if _.isFunction @$window.callPhantom
