# Jekyll Docker

This repository holds a (very) simple Docker image containing _just_
Bundler and Jekyll. I created this to be able to generate an arm32v6
image with this tools. Please refer to [official Jekyll images][1] for
better functionality and support.

[1]: https://github.com/envygeeks/jekyll-docker

## Usage

### Build Jekyll Site

```shell
docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  -it rockstorm/jekyll \
  bundle exec jekyll build
```

### Serve Jekyll Site

```shell
docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  --publish [::1]:4000:4000 \
  rockstorm/jekyll \
  bundle exec jekyll serve --host 0.0.0.0
```

Web site is now accesible at http://localhost:4000 on the host.

## Configuration

### Build Arguments

Optional build arguments:

| Argument       | Default Value |
| ---------      | :-----------: |
| RUBY_VERSION   | 3.1           |
| ALPINE_VERSION | 3.15          |

Example:
```shell
docker build -t myjekyll --build-arg RUBY_VERSION=2.7.5 .
```

### Additional Gems

The process will attempt to install any dependencies that you list
inside of `Gemfile`. If supplied, it will match the versions you have
in `Gemfile.lock`.

The defualt `Gemfile` is very minimal with only the gems required to
run Jekyll's example blog. It is expected that you overwrite this
`Gemfile` with your own in order to generate a docker image with all
the gems needed for your project.

### Run Environment Variables

| Variable        | Default Value |
| ---------       | :-----------: |
| JEKYLL_DATA_DIR | /svr/jekyll   |




