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

# push an image to vetted-registry (pull and tag busybox for this purpose)
docker pull busybox
docker tag busybox localhost:55000/busybox
docker push localhost:55000/busybox
# you should see the jenkins job kick off!

# recreate vetted-registry container
docker-compose up --force-recreate vetted-registry
# --renew-anon-volumes/-V recreates the anonymous volumes too - which the registry uses by default to store data
docker-compose up --force-recreate --renew-anon-volumes vetted-registry

# push test to registry
curl -X POST -H "Content-Type: application/json" http://localhost:8190/dockerregistry-webhook/notify -d "@test-notify-event.json"

# destroy everything, including orphan services & volumes (named & anonymous, but not external volumes)
docker-compose down --remove-orphans --volumes

```

## Grand finale mongo / notification challenge

- check out the `grand-finale-notification-challenge` branch
