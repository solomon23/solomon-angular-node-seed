# setup the routes
appModule.config ["$routeProvider", ($routeProvider) ->

    requiresAuth = ["$q", "auth", "$location", ($q, auth, $location) ->
        deferred = $q.defer()
        if auth.isAuthed()
            deferred.resolve()
        else
            deferred.reject()
            $location.path("/login").replace()

        deferred.promise
    ]

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

    $routeProvider.when "/login",
        templateUrl: "partials/pages/login.html"
        controller: "LoginController"

    $routeProvider.when "/admin",
        templateUrl: "partials/pages/admin.html"
        controller: "AdminController"
        resolve: auth: requiresAuth

    $routeProvider.otherwise redirectTo: "/"
]