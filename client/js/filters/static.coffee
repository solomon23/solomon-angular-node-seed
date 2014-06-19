###
    Filter to map static content to versioned static content
###

appModule.filter "static", [
    "config"
    (config) ->
        # setup the lookup
        _staticLookup = {}

        _lookup = (key) ->
            val = globals.staticConfig.mapping[key]

            if val
                idx = key.lastIndexOf "."
                val = "#{key.slice 0, idx}.#{val}#{key.slice idx}"

            val

        (key) ->
            # lazy resolve them
            if not _staticLookup[key]
                _staticLookup[key] = val: _lookup key

            map = _staticLookup[key].val ? key

            # prepend the static server
            "#{config.cdn}#{map}"
]