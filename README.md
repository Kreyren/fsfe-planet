# fsfe planet

This repo contains the fsfe blog aggregator based on [venus](http://intertwingly.net/code/venus/docs/index.html).

# Development setup

Requirements:
* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Save time by commenting out some languages in the [Dockerfile](./Dockerfile):

    ...
    # RUN planet /home/venus/lang/da/planet_da.ini
    RUN planet /home/venus/lang/de/planet_de.ini
    RUN planet /home/venus/lang/en/planet_en.ini
    # RUN planet /home/venus/lang/eo/planet_eo.ini
    ...

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
