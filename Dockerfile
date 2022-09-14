FROM ruby:3.1.2

RUN apt-get update \
  && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -  \
  && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs \
  && apt-get clean \
  && npm install --global yarn \
  && rm -rf /var/lib/apt/lists/* \
  &&  mkdir /monoiroha

ENV APP_ROOT /monoiroha
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
