define ["appModule"], (appModule) ->
    # add the service
    appModule.service "config", [ -> globals.config ]