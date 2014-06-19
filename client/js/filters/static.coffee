###
    Filter to map static content to versioned static content
###

appModule.filter "static", [
    "config"
    (config) ->
        # setup the lookup
        STATIC_LOOKUP = {}

        _lookup = (key) ->
            val = globals.staticConfig.mapping[key]

            if val
                idx = key.lastIndexOf "."
                val = key.slice(0, idx) + "." + val + key.slice(idx)

            val

        (key) ->
            # lazy resolve them
            if not STATIC_LOOKUP[key]
                STATIC_LOOKUP[key] = val: _lookup key

            map = STATIC_LOOKUP[key].val ? key

            # prepend the static server
            "#{config.cdn}#{map}"
]