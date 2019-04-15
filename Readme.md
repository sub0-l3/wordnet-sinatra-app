To run without docker:
```
> ruby dictionary.rb 
== Sinatra/1.4.5 has taken the stage on 4567 for development with backup from Thin
>> Thin web server (v1.5.1 codename Straight Razor)
>> Maximum connections set to 1024
>> Listening on 0.0.0.0:4567, CTRL+C to stop
```

Navigate to 
http://localhost:4567/meaning?word=magic
Output:
```
Overview of noun magic

The noun magic has 2 senses (first 1 from tagged texts)
                                          
1. (4) magic, thaumaturgy -- (any art that invokes supernatural powers)
2. magic trick, conjuring trick, trick, magic, legerdemain, conjuration, thaumaturgy, illusion, deception -- (an illusory feat; considered magical by naive observers)

Overview of adj magic

The adj magic has 1 sense (first 1 from tagged texts)
                                            
1. (3) charming, magic, magical, sorcerous, witching, wizard, wizardly -- (possessing or using or characteristic of or appropriate to supernatural powers; "charming incantations"; "magic signs that protect against adverse influence"; "a magical spell"; "'tis now the very witching time of night"- Shakespeare; "wizard wands"; "wizardly powers")

```
### Below docker setup is WIP ->

Ref. https://rubyplus.com/articles/2461-Docker-Basics-Running-a-Hello-World-Sinatra-App-in-a-Container
Ref. https://github.com/sinatra/sinatra
Ref. https://hub.docker.com/_/ruby
Ref. 


The above example Dockerfile expects a Gemfile.lock in your app directory. 
This docker run will help you generate one. Run it in the root of your app, next to the Gemfile:
```
sudo docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install
```
\# Build the image and tag it
```
sudo docker build -t subhrajit/wordnet-sinatra-app  .
```
To run
```
sudo docker run -p 4567:4567 subhrajit/wordnet-sinatra-app
```
\# check running containers
```
sudo docker ps
```
\# login as user
```
sudo docker exec -it  9c799613c339 bash
```
\# check listening ports inside the Container
```
netstat -an | grep LISTEN
```
\# *OR*
```
curl localhost:4567
```
\# make some changes in src code & restart to see changes
```
sudo docker restart 9c799613c339 
```
\# Open in browser below URL
```
localhost:4567
```
### Issues faced 

- networking - curl (56) Recv failure: Connection reset by peer 
 Adding the below line in dictionary.rb file fixed the issue
 As the port was not reachable from outside the Container
  `set :bind, '0.0.0.0'`

### Install wordnet 3.0
Download URL -> https://wordnet.princeton.edu/download/current-version

This solution helped,
https://bugzilla.redhat.com/show_bug.cgi?id=902561

Steps to install:
\# Install the dependencies tcl8.6, will be installed at `/usr/lib/`
```
sudo apt-get install tcl-dev tk-dev mesa-common-dev libjpeg-dev libtogl-dev
./configure
```
\# Add this to CPPFLAGS located at src/Makefile
`CPPFLAGS = -DUSE_INTERP_RESULT`
```
make
sudo make install
cd /usr/local/WordNet-3.0/bin
./wn  magic -over
```