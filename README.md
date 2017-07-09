# Docker-101 Project - Exploring docker

There are official images for postgres, ruby, node and rails.  This is to learn how to build images and create "developer" versions.  Ruby, node and rails are installed as they would on a development machine, not production.  This way they can be used for local development.

## Getting Started

You will need to update the `docker-compose.yml` files to reflect you local environment unless you clone into a sandbox folder under $Home(~).
```
volumes:
  - ~/sandbox/docker-101/myapp:/home/mark/myapp
```
  The docker images are built with a default user `mark`. You can update the images (Dockerfile) with a different user if you choose.
```
git clone git@github.rds.lexmark.com:greenem/docker-101.git
cd Docker-101
# Build the base images
./build.sh
# Build the sample Rails app with PostgreSQL
docker-compose build
# Generate the Rails skeleton app
docker-compose run app rails new . --force --database=postgresql --skip-bundle
```

Uncomment the line in your new Gemfile which loads therubyracer, so you’ve got a Javascript runtime:

`# gem 'therubyracer', platforms: :ruby`

Now that you’ve got a new Gemfile, you need to build the image again. (This, and changes to the Dockerfile itself, should be the only times you’ll need to rebuild.)
```
docker-compose build
```

### Connect the database
The app is now bootable, but you’re not quite there yet. By default, Rails expects a database to be running on localhost - so you need to point it at the db container instead. You also need to change the database and username to align with the defaults set by the postgres image.

Edit the contents of config/database.yml with the following:

```
default: &default
  adapter: postgresql
  encoding: unicode
  template: template0
...
```
```
development:
  <<: *default
  database: myapp_development
...
  username: myapp
  password: myapp
  host: database
...
test:
  <<: *default
  database: myapp_test
  username: myapp
  password: myapp
  host: database

```

You can now boot the app with:
```
docker-compose up
```

Finally, you need to create the database. In another terminal, run:
```
docker-compose run app rake db:create
```

To see it work on linux go to localhost:3000.  On OSx use your docker toolbox IP instead of localhost (see below).
```

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/


docker is configured to use the default machine with IP 192.168.99.100
For help getting started, check out the docs at https://docs.docker.com
```

Note: If you stop the example application and attempt to restart it, you might get the following error: app_1 | A server is already running. Check /myapp/tmp/pids/server.pid. One way to resolve this is to delete the file tmp/pids/server.pid, and then re-start the application with docker-compose up.

If you get an error about port 5432 in use, stop your local instance of postgres.  On linux, sudo service postgresql stop.  On OSx brew services stop postgres.

See: https://docs.docker.com/compose/rails/

### Ruby, Rails and PostgreSQL

There are docker-compose files to run the ruby, rails and postgres containers independent of the example application (myapp).

```
# In mark-ruby
docker-compose run ruby
```
```
# In mark-rails
docker-compose run rails
```
```
# In mark-postgres
docker-compose run database
# On Linux run `psql -h localhost -U mark` to connect to the server
# On OSx run `psql -h [docker IP] -U mark`
```
### Elixir and Phoenix

```
# In mark-phoenix
docker-compose build
docker-compose run phoenix mix phoenix.new hello_phoenix
docker-compose up
```
Edit config/dev.exs and set hostname: "database" before bring up the environment.  hello_phoenix is created on your locally mapped folder (see volumes:)

To see it work on linux go to localhost:4000.  On OSx (using toolbox) use your docker toolbox IP instead of localhost.
