# add the service
appModule.service "remote", ["$http", "$resource",

    class
        constructor: (@$http, @$resource) ->

        httpRequest: ->
            @$http.get "/api/getdata"

        resourceRequest: ->
            @$resource "/api/getdata"

        secureGet: ->
            @$http.get "/api/getsecuredata"
]