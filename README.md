# dash

Docker image of [rq-dashboard](https://github.com/nvie/rq-dashboard)
with [Flask basic auth](http://flask-basicauth.readthedocs.org/en/latest/).

# Usage

```
docker run -d quay.io/humu/dash -p 5000:5000 \
  -e BASIC_AUTH_USERNAME=... \
  -e BASIC_AUTH_PASSWORD=... \
  -e REDIS_URL=... \
  -e REDIS_HOST=... \
  -e REDIS_PORT=... \
  -e REDIS_PASSWORD=... \
  -e REDIS_DB=... \
  -e DASH_LOG_FACILITY=... \
  /sbin/my_init
```

where:

* `BASIC_AUTH_USERNAME` - username to authenticate rq-dashboard users
* `BASIC_AUTH_PASSWORD` - password to authenticate rq-dashboard users
* `DASH_LOG_FACILITY` - name of syslog facility for log messages

The following are from rq-dashboard itself (read its code for details).

* `REDIS_URL` - full URL of redis (in lieu of `REDIS_HOST` and `REDIS_PORT`)
* `REDIS_HOST` - redis host (only if `REDIS_URL` not set)
* `REDIS_PORT` - redis port (only if `REDIS_URL` not set)
* `REDIS_PASSWORD` - redis password
* `REDIS_DB` - redis database number

## Mac boot2docker notes

With boot2docker on a Mac the docker host is not the Mac but a VirtualBox VM.

Running this in a window and leaving it open will let you connect to the docker
image on a Mac:

```
boot2docker ssh -vnNTL 9181:localhost:9181
```

This is only needed for running on a Mac. More background info
[here](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md)
