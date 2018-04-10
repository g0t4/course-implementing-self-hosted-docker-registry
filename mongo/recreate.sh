#!/bin/bash

# remove containers, volumes (named and anonymous, not external) & orphan containers
docker-compose down --volumes --remove-orphans
docker-compose build --pull # separate so we can explicitly pull before building 
docker-compose up -d
docker-compose logs -f learning-jenkins # drop service name to watch everything
