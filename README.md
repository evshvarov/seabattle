# seabattle
This is cool terminal game "Sea Battle" written in InterSystems IRIS in ObjectScript
# Documentation
The game randomly hides the ship and let's you try to find it.
The game uses two globals: ^Board and ^Ships
Class Game has two parameters:
BoardRange - Sea battle the field range
Rounds - the number of rounds to try

# Installation with ZPM

zpm:USER>install eshvarov-sample-seabattle

# Installation with Docker

Make sure you have Docker and Git installed

Git clone the repo
run in terminal
```
$ docker-compose up -d
```
This will create the container and installs code into "SEABATTLE" namespace
Open IRIS terminal:
```
$ docker-compose exec iris iris session iris
USER>do ##class(eshvarov.sample.SeaBattle.Game).Run()
```


