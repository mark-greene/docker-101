FROM mark-ruby

USER root

RUN set -x \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  libpq-dev

USER mark

RUN set -x \
  && export PATH="$HOME/.rbenv/bin:$PATH" \
  && export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH" \
  && eval "$(rbenv init -)" \
  && export PATH="$HOME/.nodenv/bin:$PATH" \
  && eval "$(nodenv init -)" \
  && gem install rails \
  && rbenv rehash \
  && rails -v \
  && git config --global color.ui true \
  && git config --global user.name "Mark Greene" \
  && git config --global user.email "mark.greene@yahoo.com"

EXPOSE 3000
