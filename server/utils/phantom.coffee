phantom = require "phantom"

renderHtml = (url, cb) ->
    phantom.create '--load-images=no', '--local-to-remote-url-access=yes', (ph) ->
        ph.createPage (page) ->         
            timer = null

            page.set "onCallback", () ->
                clearTimeout timer if timer

                page.get "content", (c) ->
                    cb c
                    page.close()
                    ph.exit()
        
            # set a timeout in case the page doesn't indicate it's complete
            page.set "onInitialized", ->
               page.evaluate ->
                    timer = setTimeout ->
                        window.callPhantom()
                    , 5000
                
            page.open url

exports.get = (url, cb) ->
    renderHtml url, (content) ->
        cb null, content