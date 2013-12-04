define ["appModule"], (appModule) ->
    # add the service
    appModule.service "remote", ["$http", "$resource", 

        class
            constructor: (@$http, @$resource) ->

            httpRequest: ->
                @$http method: "GET", url: "/api/getdata"

            resourceRequest: ->
                @$resource "/api/getdata"
    ]