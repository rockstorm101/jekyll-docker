# Jekyll Docker

This repository holds a (very) simple Docker image containing _just_
Bundler and Jekyll (and some other Ruby gems). I created this to
generate images with two requisites which were not satisfied by the
[official Jekyll images][1]:

- Run on an old Raspberry (i.e. arm32v6 architecture).
- Run offline.

[1]: https://github.com/envygeeks/jekyll-docker

## Usage

### Build Jekyll Site

```shell
docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  rockstorm/jekyll build
```

### Serve Jekyll Site

```shell
docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  --publish 4000:4000 \
  rockstorm/jekyll serve --host 0.0.0.0
```

Web site is now accessible at http://localhost:4000 on the host.

### Start New Jekyll Site

```shell
docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  rockstorm/jekyll new .
```

## Configuration

### Additional Gems

The process will attempt to install any dependencies that you list
inside of `Gemfile`. If supplied, it will match the versions you have
in `Gemfile.lock`.

The supplied `Gemfile` contains the gems that I use. It is expected
that you overwrite this `Gemfile` with your own in order to generate a
docker image with all the gems needed for your project.
