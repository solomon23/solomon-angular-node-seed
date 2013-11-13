define ["appModule"], (appModule) ->
    
    # setup the routes
    appModule.config ["$routeProvider", ($routeProvider) ->
      
        $routeProvider.when "/view1", 
            templateUrl: "partials/pages/first-page.html"
            controller: "Page1Controller"

        $routeProvider.when "/view2", 
            templateUrl: "partials/pages/second-page.html"
            controller: "Page2Controller"

        $routeProvider.otherwise redirectTo: "/view1"
    ]