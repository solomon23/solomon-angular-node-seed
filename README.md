solomon-angular-node-seed
=========================

This is a seed start a project to build a production ready website containing

+ [AngularJS](http://angularjs.org/)
+ [RequireJS](http://requirejs.org/)
+ [Node.JS](http://nodejs.org/)
+ [LESS](http://lesscss.org/)
+ SEO
+ Versioned static content
+ Easy production deployment

## Pre-reqs

Please install the following before building

+ [Node.JS](http://nodejs.org/)
+ [Grunt](http://gruntjs.com/)
+ [PhantomJS](http://phantomjs.org/)
+ [Heroku](https://www.heroku.com/) account w/ toolset
+ [AWS S3](http://aws.amazon.com/) account

## Quick start

Clone down the repo

````
git clone https://github.com/solomon23/solomon-angular-node-seed.git
npm install
grunt server
````

Navigate to http://localhost:3000 and confirm site is functioning

````
grunt build
cd ./build
git init
add .
git commit -am "new"

heroku create
git push heroku master

heroku ps:scale web=1
heroku config:set NODE_ENV=production
heroku config:set PATH="/usr/local/bin:/usr/bin:/bin:/app/vendor/phantomjs/bin"
````

## Static content

Create a file called aws.json in your home folder:

````
{
    "key": "xxx",
    "secret": "xxx",
    "bucket": "xxx"
}
````

Modify the config file ./server/config.coffee

````
prod = 
    cdn: "http://s3.amazonaws.com/xxx"
````    
  
Deploy to s3 with

`
grunt s3
`

# Redeploy to heroku

Subsequent deploys to heroku can use the same site

````
grunt build
cd ./build
git add .
git commit -am "New"
git push heroku master
````
