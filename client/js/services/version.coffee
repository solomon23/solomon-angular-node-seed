define ["appModule"], (appModule) ->
    
    # Demonstrate how to register services
    # In this case it is a simple value service.
    appModule.value 'version', '1.0'