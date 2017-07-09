FROM mark-rails

USER root

ENV PATH /home/mark/.rbenv/shims:$PATH

RUN mkdir myapp

WORKDIR /home/mark/myapp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN chown -R mark:mark .

USER mark

RUN bundle install

ADD . myapp
