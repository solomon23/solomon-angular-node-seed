define ["appModule"], (appModule) ->
    
    # setup the routes
    appModule.config ["$routeProvider", ($routeProvider) ->
      
        $routeProvider.when "/", 
            templateUrl: "partials/pages/first-page.html"
            controller: "Page1Controller"
            resolve:
                remoteData:["remote", (remote) ->
                    # kick off a request and return the promise
                    remote.resourceRequest().get().$promise
                ] 

        $routeProvider.when "/view2", 
            templateUrl: "partials/pages/second-page.html"
            controller: "Page2Controller"

        $routeProvider.otherwise redirectTo: "/"
    ]