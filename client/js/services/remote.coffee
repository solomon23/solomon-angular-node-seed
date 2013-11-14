define ["appModule"], (appModule) ->

    class remote
        constructor: (@$http) ->

        getData: ->
            @$http method: "GET", url: "/api/getdata"

    # add the service
    appModule.factory "remote", [
        "$http"
        ($http) -> new remote $http
    ]