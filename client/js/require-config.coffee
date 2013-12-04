exp = window ? exports

exp.requireConfig =

    baseUrl: if staticConfig? then staticConfig.cdn + "/" else "/"

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
        "lib/bootstrap/affix":      ["jquery"]
        "lib/bootstrap/alert":      ["jquery"]
        "lib/bootstrap/button":     ["jquery"]
        "lib/bootstrap/carousel":   ["jquery"]
        "lib/bootstrap/collapse":   ["jquery"]
        "lib/bootstrap/dropdown":   ["jquery"]
        "lib/bootstrap/modal":      ["jquery"]
        "lib/bootstrap/scrollspy":  ["jquery"]
        "lib/bootstrap/tab":        ["jquery"]
        "lib/bootstrap/tooltip":    ["jquery"]
        "lib/bootstrap/popover":    ["lib/bootstrap/tooltip"]
        "lib/bootstrap/transition": ["jquery"]
        "lib/bootstrap/typeahead":  ["jquery"]

        # angular
        "lib/angular/angular-route":    ["angular"]
        "lib/angular/angular-resource": ["angular"]
        "appModule":                    ["angular"]
        "templates":                    ["appModule"]

exp.requireConfig