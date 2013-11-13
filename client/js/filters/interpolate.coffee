define ["appModule"], (appModule) ->
    
    # Filter
    interpolate = (version) ->
        (text) ->
            String(text).replace /\%VERSION\%/mg, version

    appModule.filter "interpolate", [
        "version"
        interpolate
    ]