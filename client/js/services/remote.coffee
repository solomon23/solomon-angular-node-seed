define ["appModule"], (appModule) ->

    class remote
        constructor: (@$http) ->

        getData: ->
            @$http method: "GET", url: "/getdata"

    # add the service
    appModule.factory "remote", [
        "$http"
        ($http) -> new remote $http
    ]