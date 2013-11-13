define ["appModule"], (appModule) ->
    
    # Directive
    appVersion = (version) ->
        (scope, elm, attrs) ->
            elm.text version

    # register the directive
    appModule.directive "appVersion", [
        "version"
        appVersion
    ]