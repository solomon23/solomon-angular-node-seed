###
    Filter to map static content to versioned static content
###

appModule.filter "static", [
    "config"
    (config) ->
        (text) ->
            map = globals.staticConfig.mapping[text] ? text

            # prepend the static server
            "#{config.cdn}#{map}"
]