# Ref. https://rubyplus.com/articles/2461-Docker-Basics-Running-a-Hello-World-Sinatra-App-in-a-Container
# Ref. https://github.com/sinatra/sinatra
# Ref. https://hub.docker.com/_/ruby
# Ref. 


# The above example Dockerfile expects a Gemfile.lock in your app directory. 
# This docker run will help you generate one. Run it in the root of your app, next to the Gemfile:
sudo docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install

# Build the image and tag it
sudo docker build -t subhrajit/wordnet-sinatra-app  .

sudo docker run -p 4567:4567 subhrajit/wordnet-sinatra-app

# check running containers
sudo docker ps

# login as user
sudo docker exec -it  9c799613c339 bash

# check listening ports inside the Container
netstat -an | grep LISTEN
# OR
curl localhost:4567

# make some changes in src code & restart to see changes
sudo docker restart 9c799613c339 

# open in browser below URL
localhost:4567

* Issues faced *

- networking - curl (56) Recv failure: Connection reset by peer 
# adding the below line in dictionary.rb file fixed the issue
# as the port was not reachable from outside the Container
  set :bind, '0.0.0.0' 