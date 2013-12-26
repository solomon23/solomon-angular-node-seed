_  = require "underscore"
Fs = require "fs"

module.exports = (grunt) ->
    grunt.loadNpmTasks "grunt-contrib-coffee"
    grunt.loadNpmTasks "grunt-contrib-less"
    grunt.loadNpmTasks "grunt-contrib-requirejs"
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.loadNpmTasks "grunt-contrib-cssmin"
    grunt.loadNpmTasks "grunt-contrib-copy"
    grunt.loadNpmTasks "grunt-contrib-clean"
    grunt.loadNpmTasks "grunt-contrib-compress"

    grunt.loadNpmTasks "grunt-newer"
    grunt.loadNpmTasks "grunt-nodemon"
    grunt.loadNpmTasks "grunt-concurrent"
    grunt.loadNpmTasks "grunt-angular-templates"
    grunt.loadNpmTasks "grunt-filerev"
    grunt.loadNpmTasks "grunt-filerev-assets"
    grunt.loadNpmTasks "grunt-env"
    grunt.loadNpmTasks "grunt-shell"
    grunt.loadNpmTasks "grunt-aws-s3"

    
    grunt.registerTask "default", ["build"]
    
    # combine the javascript files using the requirejs config
    grunt.registerTask "jscombine", "Require.Js optimization", ->
        config = require "./client/js/require-config.coffee"
        requireConfig = config.requireConfig

        # client build config needs some extra items
        _.extend requireConfig,
            name:     "./lib/almond"
            baseUrl:  "build/temp"
            include:  ["js/main.js"]
            out:      "./build/public/js/combined.js"

        grunt.config.set "requirejs",
            optimize:
                options: requireConfig

        grunt.task.run "requirejs"

    # Replaces all the image urls with the static content version including the cdn url
    grunt.registerTask "fixcssimges", "Fixes the css image urls", ->
        cdn    = require("./build/server/config").cdn
        cssDir = "./build/public/css"
        map    = grunt.file.readJSON "./build/server/assets.json"
        files  = Fs.readdirSync cssDir

        _.each files, (f) ->
            file = "#{cssDir}/#{f}"
            contents = grunt.file.read file

            for key, value of map
                value = cdn + value
                contents = contents.replace new RegExp(key, "g"), value
            
            grunt.file.write file, contents
            console.log "File #{file} image urls updated"

    # generates the client config from the server config
    grunt.registerTask "buildConfig", "Building client config", ->
        env = process.env.BUILD_ENV
        process.env.BUILD_ENV = "client"

        config  = require "./server/config"
        buildTo = if process.env.NODE_ENV is "production" then "build/temp" else "public"        

        Fs.writeFileSync "./#{buildTo}/js/config.js", "globals.config = #{JSON.stringify(config, null, 4)};"
        process.env.BUILD_ENV = env

    grunt.registerTask "server", ["builddev", "concurrent"]

    grunt.registerTask "deploy", ["shell:gitadd", "shell:gitcommit", "shell:gitpush"]

    grunt.registerTask "static", [
        # gzip the static content
        "compress:js"
        "compress:css"

        # copy the zip files over the old ones
        "copy:zipfiles"

        # clean up the temp ones
        "clean:zipped"

        # copy them up
        "aws_s3:prod"
    ]

    grunt.registerTask "builddev", [
        # set us to development
        "env:dev"

        # removing the public dir
        "clean:public"

        # turn the client coffee into js into the public folder
        "coffee:dev"

        # generate the client config
        "buildConfig"

        # compile the less CSS
        "less:dev"

        # create the single template file
        "ngtemplates"
    ]

    grunt.registerTask "build", [
        # set our environment to production
        "env:prod"

        # remove build folder
        "clean:build"

        # turn the client coffee into js in the build/temp
        "coffee:prod"

        # compile the templates
        "ngtemplates"

        # generate the client config
        "buildConfig"

        # copy the templates and lib to build/temp
        "copy:client"

        # combine all the js files
        "jscombine"

        # compile the css
        "less:prod"

        # minify the css    
        "cssmin"

        # set versions on all the files
        "filerev:files"

        # create a server map
        "filerev_assets"

        # copy over server coffee files
        "copy:server"

        # use cdn image urls in the css
        "fixcssimges"

        # rev the css file after it's been updated
        "filerev:css"

        # write out the assets again but with the css
        "filerev_assets"

        # copy over deploy files
        "copy:heroku"

        # remove the temp files
        "clean:temp"
    ]

    grunt.initConfig
        env:
            prod:
                NODE_ENV : "production"

            dev:
                NODE_ENV : "development"

        clean:
            build: 
                files: [{
                    dot: true
                    src: [
                        "build/*"
                        "!build/.git*"
                    ]
                }]

            temp: ["build/temp"]

            zipped: ["build/**/*.gz"]

            public: ["public"]

        concurrent:
            dev:
                tasks: ["nodemon", "watch"]
                options:
                    logConcurrentOutput: true

        nodemon:
             dev:
                options:
                    watchedFolders: ["server"]
                    file: "./server/app.coffee"

        coffee:
            dev:
                options:
                    bare: true
                    sourceMap: true
                    sourceRoot: ""

                expand: true
                cwd: "client"
                src: ["./**/*.coffee"]
                dest: "public"
                ext: ".js"
            
            prod:
                options:
                    bare: true
                    sourceMap: false
                    sourceRoot: ""

                expand: true
                cwd: "client"
                src: ["./**/*.coffee"]
                dest: "build/temp"
                ext: ".js"

        less:
            dev:
                options: yuicompress: true
                files:
                    "./public/css/app.css": "./client/less/app.less"

            prod:
                files:
                    "./build/temp/css/app.css": "./client/less/app.less"

        # put hash numbers on the assets
        filerev:
            files:
                src: [
                    "./build/public/js/**/*.js"
                    "./build/public/lib/**/*.js"
                    "./build/public/images/**/*.{png,jpg,jpeg,gif,webp,svg}"
                    "./build/public/fonts/**/*.{eot,svg,ttf,woff}"
                ]
            css:
                src:[
                    "./build/public/css/**/*.css"
                ]

        # create a map file for all the assets
        filerev_assets:
            prod:
                options:
                    cwd: "build/public"
                    dest: "build/server/assets.json"

        cssmin:
            minify:
                expand: true
                cwd: "build/temp"
                src: ["css/app.css"]
                dest: "build/public"
                ext: ".css"

        copy:
            client:
                files: [
                    # external lib files
                    {expand: true, src: "lib/**/*.js", cwd: "client/", dest: "./build/temp/"}

                    # combined template file
                    {src: "public/js/templates.js", dest: "build/temp/js/templates.js"}

                    # image files
                    {expand: true, src: "images/**", cwd: "client/", dest: "./build/public/"}

                    # font files
                    {expand: true, src: "fonts/**", cwd: "client/", dest: "./build/public/"}
                ]

            server:
                files: [
                    {src: ["server/**"], dest: "build/"}
                ]

            heroku: 
                files: [
                    {src: ["Procfile"], dest: "build/"}
                    {src: "package.json", dest: "build/package.json"}
                    {src: ".buildpacks", dest: "build/.buildpacks"}
                ]

            zipfiles:
                files: [
                    # js files
                    {
                        expand: true
                        src: "./build/public/js/**/*.gz"
                        dest: "."
                        rename: (dest, src) ->
                            src.replace ".gz", ""
                    }

                    # css files
                    {
                        expand: true
                        src: "./build/public/css/**/*.gz"
                        dest: "."
                        rename: (dest, src) ->
                            src.replace ".gz", ""
                    }
                ]
      
        ngtemplates:
            myApp:
                cwd: "./client"
                src: "partials/**/*.html"
                dest:"./public/js/templates.js"
                options:
                    htmlmin: collapseWhitespace: true, collapseBooleanAttributes: true
                    bootstrap:  (module, script) ->
                        "define(['appModule'], function(appModule) {appModule.run(['$templateCache', function($templateCache){ #{script} }])});"

        aws: grunt.file.readJSON process.env.HOME + "/aws.json"
        aws_s3:
            options:
                accessKeyId: "<%= aws.test.key %>"
                secretAccessKey: "<%= aws.test.secret %>"
                bucket: "<%= aws.test.bucket %>"
                # region: "us-west-2"
                uploadConcurrency: 5 
                downloadConcurrency: 5
                differential: true
                maxRetries: 4

            prod:
                files:[
                    expand: true
                    src: "**"
                    dest: "public/"
                    # make sure the wildcard paths are fully expanded in the dest
                    cwd: "build/public/"                    
                    
                    params: 
                        "CacheControl": "public, max-age=630720000"
                        "ContentEncoding": "gzip"
                        "Expires": new Date(Date.now() + 63072000000);
                ]

        compress:
            js: 
                options: mode: "gzip"
                expand: true
                cwd: "build/public/js"
                src: ['**']
                dest: "build/public/js"

            css: 
                options: mode: "gzip"
                expand: true
                cwd: "build/public/css"
                src: ['**']
                dest: "build/public/css"

        shell: 
            gitadd:
                command: "git add ."
                options: 
                    stdout: true
                    execOptions: cwd: "build"

            gitcommit:
                command: "git commit -am \"new\""
                options: 
                    stdout: true
                    execOptions: cwd: "build"

            gitpush:
                command: "git push heroku master"
                options: 
                    stdout: true
                    execOptions: cwd: "build"
  
        watch:
            coffee:
                files: ["**/*.coffee", "./server/config/*.coffee"]
                tasks: ["newer:coffee:dev", "buildConfig"]

            less:
                files: ["./client/less/**/*.less"]
                tasks: ["less:dev"]

            ngtemplates:
                files: ["client/partials/**/*.html"]
                tasks: ["ngtemplates"]