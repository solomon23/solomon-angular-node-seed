# register the controller
appModule.classy.controller
    name: "Page2Controller"
    inject: ["$scope", "remote"]
    init: ->
        @$.page = "page2"

        # this will fire an api request on page load
        # this returns an object that will update itself once the data
        # is ready so it can be used directly in the page
        @$.myData = @remote.resourceRequest().get()

    watch:
        # myData will be $resolved when the data is ready
        "myData.$resolved": (val) ->
            # mark the page as complete
            @$.pageDone() if val