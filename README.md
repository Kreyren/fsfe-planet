# fsfe planet

This repo contains the fsfe blog aggregator based on [venus](http://intertwingly.net/code/venus/docs/index.html).

# Development setup

Requirements:
* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Save time on your dev machine by temporarily limiting fetching entries to some languages in the [Dockerfile](./Dockerfile):

    RUN find /home/venus/lang/ -name "planet_it.ini" -exec planet {} \;

Start the planet by running

    docker-compose up

The planet then runs at [http://localhost/](http://localhost/).

Configure different ports than 80 in the [docker-compose.yml](docker-compose.yml):

Change this

    expose:
      - 80
    
for example to

    ports:
      - 8080:80
