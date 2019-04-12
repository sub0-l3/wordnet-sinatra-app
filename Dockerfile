FROM ruby:2.5

RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get install -y vim

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 4567

CMD ["ruby", "dictionary.rb"]