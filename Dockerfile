FROM ruby:2.5

RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get install -y vim

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN apt-get install -y tcl-dev tk-dev mesa-common-dev libjpeg-dev libtogl-dev && \
	wget http://wordnetcode.princeton.edu/3.0/WordNet-3.0.tar.gz && \
	tar xvzf WordNet-3.0.tar.gz && \
	cd WordNet-3.0 && \
	./configure CPPFLAGS=-DUSE_INTERP_RESULT && \
	make && \
	make install && \
	echo 'export PATH="/usr/local/WordNet-3.0/bin:$PATH"' >> ~/.bashrc && \
	/bin/bash -c "source ~/.bashrc"


COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 4567

CMD ["ruby", "dictionary.rb"]