solomon-angular-node-seed
=========================

This is a seed start project to build a production ready website containing

+ AngulaJS
+ RequireJS
+ Node.JS
+ LESS

## Pre-reqs

Please install the following before building

+ Grunt
+ PhantomJS

## Quick start

Clone down the repo

npm install
grunt server

Navigate to http://localhost:3000 and confirm site is functioning

grunt build

cd ./build

git init
add .
git commit -am "new"

heroku create
git push heroku master

heroku ps:scale web=1
heroku config:set NODE_ENV=production



