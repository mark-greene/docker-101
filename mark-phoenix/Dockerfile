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
        inotify-tools \
        python-software-properties sqlite3 \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /var/cache/apt/*

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        esl-erlang elixir

USER mark

RUN set -x \
  && git clone https://github.com/nodenv/nodenv.git /home/mark/.nodenv \
  && git clone https://github.com/nodenv/node-build.git /home/mark/.nodenv/plugins/node-build \
  && cd ~/.nodenv && src/configure && make -C src \
  && echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> /home/mark/.bashrc \
  && echo 'eval "$(nodenv init -)"' >> /home/mark/.bashrc

RUN set -x \
  && export PATH="$HOME/.nodenv/bin:$PATH" \
  && eval "$(nodenv init -)" \
  && nodenv install 6.3.0 \
  && nodenv install iojs-3.3.1 \
  && nodenv global 6.3.0 \
  && node -v

VOLUME /sandbox

WORKDIR /home/mark

RUN set -x \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

COPY entrypoint.sh .
ENTRYPOINT ["/home/mark/entrypoint.sh"]
CMD ["bash"]
