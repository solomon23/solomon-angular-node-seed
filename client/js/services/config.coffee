define ["appModule"], (appModule) ->
    # add the service
    appModule.factory "config", [ -> globals.config ]