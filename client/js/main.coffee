requirejs.config requireConfig if requireConfig?

require [
    "angular"
    "jquery"
    "underscore"
    "appModule"
    "templates"    

    # bootstrap
    "lib/bootstrap/affix.js"
    "lib/bootstrap/alert.js"
    "lib/bootstrap/button.js"
    "lib/bootstrap/carousel.js"
    "lib/bootstrap/collapse.js"
    "lib/bootstrap/dropdown.js"
    "lib/bootstrap/modal.js"
    "lib/bootstrap/tooltip.js"
    "lib/bootstrap/popover.js"
    "lib/bootstrap/scrollspy.js"
    "lib/bootstrap/tab.js"
    "lib/bootstrap/transition.js"

    "lib/angular/angular-route.js"
    
    # the routes
    "js/routes.js"

    # services
    "js/services/version.js"
    "js/services/remote.js"

    # controllers
    "js/controllers/root.js"
    "js/controllers/page1.js"
    "js/controllers/page2.js"

    # filters
    "js/filters/interpolate.js"
    "js/filters/static.js"

    # directives
    "js/directives/app-version.js"

], (angular) ->
    angular.bootstrap $("html"), ["myApp"]