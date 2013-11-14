define ["appModule"], (appModule) ->
    
    ###
        Filter to map static content to versioned static content
    ###
    staticFilter =  ->
        (text) ->
            map = staticConfig.mapping[text] ? text
                        
            # prepend the static server
            "#{staticConfig.cdn}#{map}"

    appModule.filter "static", [
        staticFilter
    ]