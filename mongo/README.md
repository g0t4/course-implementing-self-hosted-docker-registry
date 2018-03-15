## Helpful Commands

```bash

# create everything in background:
docker-compose up -d

# open jenkins localhost:8190 and navigate to the job that is created (just one)

# tail only new jenkins log entries
docker-compose logs --tail=0 --follow learning-jenkins
# dump and follow vetted-registry logs
docker-compose logs --follow vetted-registry

## json logging is much easier to visually parse
# 1. configure logging in config.yml for vetted-registry to print json:
# log:
#     formatter: json
# 2. then listen to logs and pipe through jq to format them nicely:
# all fields:
docker-compose logs --follow vetted-registry \
	| grep --line-buffered -o '{.*}' \
    | jq 
# compact & minimal fields:
docker-compose logs --follow vetted-registry \
	| grep --line-buffered -o '{.*}' \
	| jq -c '{ time, level: .level[0:4], msg }'

# recreate vetted-registry container
docker-compose up --force-recreate vetted-registry
# --renew-anon-volumes/-V recreates the anonymous volumes too - which the registry uses by default to store data
docker-compose up --force-recreate --renew-anon-volumes vetted-registry

# destroy everything, including orphan services & volumes (named & anonymous, but not external volumes)
docker-compose down --remove-orphans --volumes

```