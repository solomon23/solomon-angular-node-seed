# Directive
appModule.directive "appVersion", [
    "version"
    (version) ->
        (scope, elm, attrs) ->
            elm.text version
]