define ["appModule"], (appModule) ->
    
    ###
        Filter to map static content to versioned static content
    ###
    staticFilter =  ->
        (text) ->
            staticMapping[text] ? text

    appModule.filter "static", [
        staticFilter
    ]