phantom = require "phantom"

renderHtml = (url, cb) ->
    phantom.create '--load-images=no', '--local-to-remote-url-access=yes', (ph) ->
        ph.createPage (page) ->            
            page.set "onCallback", () ->
                page.get "content", (c) ->
                    cb c
                    page.close()
                    ph.exit()
        
            page.set "onInitialized", ->
               page.evaluate ->
                    setTimeout ->
                        window.callPhantom();
                    , 2000
                
            page.open url
            return

        return

exports.get = (url, cb) ->
    renderHtml url, (content) ->
        cb null, content