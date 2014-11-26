# register the controller
appModule.classy.controller
    name: "Page1Controller"
    inject: ["$scope", "$log", "remote", "remoteData"]
    init: ->
        @$.page = "page1"

        # this data is retrieved by the route and blocks page loading until it's ready
        @$.myData = @remoteData.message

        @remote.secureGet()
            .success (res) ->
                @$.secureData = res.message

            .error (res) ->
                @$.errorData = "unable to get secure data.  login!"

            .finally ->
                @$.pageDone()
