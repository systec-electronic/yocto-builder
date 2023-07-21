# Dockerfile for Yocto build

This Dockerfile is based on <https://github.com/gmacario/easy-build/blob/master/build-yocto/Dockerfile> with the following adjustments:

* jenkins user removed
* regular uid set to 1000
* /home/build/.ssh added

The shipped `docker-compose.yml` is intended to be used to start the container.
The global git config from the host is mapped into the container

# Starting the container (development)

`docker-compose run --rm yocto`

This will automatically generate the necessary image and start the container.

## .netrc

The development composition has a mapped `.netrc` file. This is used for authenticating to
gitlab server on HTTP(S) protocol by using an access token. The (partial) file content is:
```
machine srv-gitlab.intern.systec-electronic.com
login <username>
password <access-token>
```

An access token can be generated in the user page <http://srv-gitlab.intern.systec-electronic.com/profile/personal_access_tokens>
Scope has to be at least `read_repository` checked.

# Container for gitlab CI

The default container has a ~/.netrc preconfigured for gitlab CI pipeline runs.
It uses `CI_JOB_TOKEN` for accessing repositories.

Start command is `docker-compose run --rm yocto-ci`. The only difference to the container above is that .netrc is not mapped.
