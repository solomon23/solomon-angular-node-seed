define ["appModule"], (appModule) ->
    
    ###
        Filter to map static content to versioned static content
    ###
    staticFilter =  ->
        (text) ->
            map = staticMapping[text] ? text
            
            # chop off the first slash
            map = map.substring 1 if map.charAt[0] is "/"

            # prepend the static server
            "/static/#{map}"

    appModule.filter "static", [
        staticFilter
    ]