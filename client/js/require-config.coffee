exp = window ? exports

exp.requireConfig =

    baseUrl: "/"

    # if we use the order plugin, we only need a shim for underscore
    paths:
        jquery:     "lib/jquery-1.10.2"
        underscore: "lib/underscore"
        angular:    "lib/angular/angular"

        # angular services
        appModule: "js/app"
        templates: "js/templates"

    shim:
        jquery:
            exports: "$"

        underscore:
            exports: "_"
            init:    -> _

        angular:
            exports: "angular"
            deps:    ["jquery"]
            init:    -> angular            
        
        # for bootstrap
        "lib/bootstrap/affix.js":      ["jquery"]
        "lib/bootstrap/alert.js":      ["jquery"]
        "lib/bootstrap/button.js":     ["jquery"]
        "lib/bootstrap/carousel.js":   ["jquery"]
        "lib/bootstrap/collapse.js":   ["jquery"]
        "lib/bootstrap/dropdown.js":   ["jquery"]
        "lib/bootstrap/modal.js":      ["jquery"]
        "lib/bootstrap/scrollspy.js":  ["jquery"]
        "lib/bootstrap/tab.js":        ["jquery"]
        "lib/bootstrap/tooltip.js":    ["jquery"]
        "lib/bootstrap/popover.js":    ["lib/bootstrap/tooltip.js"]
        "lib/bootstrap/transition.js": ["jquery"]
        "lib/bootstrap/typeahead.js":  ["jquery"]

        # angular
        "lib/angular/angular-route.js": ["angular"]
        "appModule":                    ["angular"]
        "templates":                    ["appModule"]

exp.requireConfig