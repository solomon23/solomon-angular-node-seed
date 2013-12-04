define ["appModule"], (appModule) ->

    class remote
        constructor: (@$http, @$resource) ->

        httpRequest: ->
            @$http method: "GET", url: "/api/getdata"

        resourceRequest: ->
            @$resource "/api/getdata"            

    # add the service
    appModule.factory "remote", [
        "$http"
        "$resource"
        ($http, $resource) -> new remote $http, $resource
    ]