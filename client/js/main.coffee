requirejs.config requireConfig if requireConfig?

require [
    "angular"
    "config"
    "jquery"
    "underscore"
    "appModule"
    "templates"    

    # bootstrap
    "lib/bootstrap/affix"
    "lib/bootstrap/alert"
    "lib/bootstrap/button"
    "lib/bootstrap/carousel"
    "lib/bootstrap/collapse"
    "lib/bootstrap/dropdown"
    "lib/bootstrap/modal"
    "lib/bootstrap/tooltip"
    "lib/bootstrap/popover"
    "lib/bootstrap/scrollspy"
    "lib/bootstrap/tab"
    "lib/bootstrap/transition"

    "lib/angular/angular-route"
    "lib/angular/angular-resource"
    
    # the routes
    "js/routes"

    # services
    "js/services/version"
    "js/services/remote"
    "js/services/config"

    # controllers
    "js/controllers/root"
    "js/controllers/page1"
    "js/controllers/page2"

    # filters
    "js/filters/interpolate"
    "js/filters/static"

    # directives
    "js/directives/app-version"

    # plugins
    "lib/fastclick"

], (angular) ->
    angular.bootstrap $("html"), ["myApp"]