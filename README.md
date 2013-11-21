Solomon's Angular-Node Seed
=========================

This is a seed project to build a production ready website containing

+ [AngularJS](http://angularjs.org/)
+ [RequireJS](http://requirejs.org/)
+ [Node.JS](http://nodejs.org/)
+ [LESS](http://lesscss.org/)
+ [Bootstrap](http://getbootstrap.com/)
+ [CoffeeScript](http://coffeescript.org/)
+ [jQuery](http://jquery.com/)
+ SEO ( using phantomjs )
+ Versioned/minified/compressed static content and cdn deployment
+ Easy production deployment

## Pre-reqs

Please have the following before building

+ [Node.JS](http://nodejs.org/)
+ [Grunt](http://gruntjs.com/)
+ [PhantomJS](http://phantomjs.org/)

# Suggested tools

Optional tools that make the process smoother

+ [Sublime Text](http://www.sublimetext.com/).  Sublime project included.
+ [Heroku](https://www.heroku.com/) account w/ [toolbelt](https://toolbelt.heroku.com/) installed 
+ [AWS S3](http://aws.amazon.com/) account

## Quick start

### Clone down the repo

````
git clone https://github.com/solomon23/solomon-angular-node-seed.git
npm install
grunt server
````

Note: If you copy the contents of the pull be sure to copy the .hidden files as well

Navigate to `http://localhost:3000` and confirm site is functioning

### Create the deployment build and add it to git

````
grunt build
cd ./build
git init
add .
git commit -am "new"
````

### Create the Heroku site

````
heroku create

heroku config:add BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git 

git push heroku master

heroku ps:scale web=1
heroku config:set NODE_ENV=production
heroku config:set PATH="/usr/local/bin:/usr/bin:/bin:/app/vendor/phantomjs/bin"

heroku open
````

A browser should open with your new site functioning

## Static content

Create a file called `~/aws.json` in your home folder:

````
{
    "key": "xxx",
    "secret": "xxx",
    "bucket": "xxx"
}
````

Modify the config file `./server/config.coffee`

````
prod = 
    cdn: "http://s3.amazonaws.com/xxx"
````    
  
### Deploy to s3 with

`
grunt s3:prod
`

## Redeploy to heroku

Subsequent deploys to heroku can use the same site

````
grunt build
grunt deploy
````

or manually with


````
grunt build
cd ./build
git add .
git commit -am "New"
git push heroku master
````
