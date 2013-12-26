define ["appModule"], (appModule) ->
    
    ###
        Filter to map static content to versioned static content
    ###
    staticFilter = (config) ->
        (text) ->
            map = globals.staticConfig.mapping[text] ? text
                        
            # prepend the static server
            "#{config.cdn}#{map}"

    appModule.filter "static", [
        "config"
        staticFilter
    ]