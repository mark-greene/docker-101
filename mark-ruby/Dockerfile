FROM mark-base

RUN set -x \
  && useradd -m -d /home/mark --shell /bin/bash mark \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git-core build-essential \
        libssl-dev libreadline-dev \
        libyaml-dev libsqlite3-dev  \
        libxml2-dev libxslt1-dev libcurl4-openssl-dev \
        libffi-dev zlib1g-dev \
        python-software-properties sqlite3 \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /var/cache/apt/*

USER mark

RUN set -x \
  && git clone https://github.com/rbenv/rbenv.git /home/mark/.rbenv \
  && git clone https://github.com/rbenv/ruby-build.git /home/mark/.rbenv/plugins/ruby-build \
  && git clone https://github.com/nodenv/nodenv.git /home/mark/.nodenv \
  && git clone https://github.com/nodenv/node-build.git /home/mark/.nodenv/plugins/node-build \
  && cd ~/.nodenv && src/configure && make -C src \
  && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/mark/.bashrc \
  && echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/mark/.bashrc \
  && echo 'eval "$(rbenv init -)"' >> /home/mark/.bashrc \
  && echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> /home/mark/.bashrc \
  && echo 'eval "$(nodenv init -)"' >> /home/mark/.bashrc \
  && exec /bin/bash

RUN set -x \
  && export PATH="$HOME/.rbenv/bin:$PATH" \
  && export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH" \
  && eval "$(rbenv init -)" \
  && export PATH="$HOME/.nodenv/bin:$PATH" \
  && eval "$(nodenv init -)" \
  && rbenv install 2.3.1 \
  && rbenv global 2.3.1 \
  && ruby -v \
  && gem install bundler \
  && rbenv rehash \
  && nodenv install 6.2.2 \
  && nodenv install iojs-3.3.1 \
  && nodenv global 6.2.2 \
  && node -v
