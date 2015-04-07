HOST = quay.io
NAME = humu/dash
VERSION = 0.0.1

build:
	docker build -t $(HOST)/$(NAME):$(VERSION) --rm .

test: build
	docker run --rm $(HOST)/$(NAME):$(VERSION) /bin/bash -c rq-dashboard

tag:
	docker tag -f $(HOST)/$(NAME):$(VERSION) $(HOST)/$(NAME):latest

release: tag
	docker push $(HOST)/$(NAME)

start-redis:
	@(docker ps --filter=name=redis --filter=status=running | grep -q redis) \
	  || (echo 'starting redis' && docker run -d --name redis redis)

stop-redis:
	@(docker rm -f redis 2>/dev/null && echo stopped) \
	  || echo 'redis not running'

run: start-redis
	docker run -d \
	  --link redis:redis \
	  --name rq-dashboard \
	  -h rq-dashboard \
	  -p 9181:9181 \
      -e BASIC_AUTH_USERNAME=admin \
      -e BASIC_AUTH_PASSWORD=batteryhorsestaple \
      -e REDIS_URL=http://redis:6379 \
      -e DASH_LOG_FACILITY=rq-dashboard \
	  $(HOST)/$(NAME):$(VERSION) /sbin/my_init

.PHONY: build test tag release
