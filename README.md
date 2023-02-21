Because official image is way too complicated. By generating a customized
image this way, next container runs won't need to download or install anything
else and therefore will be way faster.

## Workflows

### Build this image

Copy this `Dockerfile`, place it next to your `Gemfile` and build as any other
Docker image. If there is a `Gemfile.lock` file, it will (bundle) install the
gems at the specified versions. Otherwise it will fetch the latest gems in
accordance with `Gemfile`.

```
docker build -t jekyll .
```

If starting from scratch, use the `Gemfile` in this repository or clone the
repository itself.


### Create a new blog

Generate blog:
```
docker run --rm -v ${PWD}:/srv/jekyll -u $(id -u):$(id -g) jekyll \
    new <blog-directory>
```


### Update every gem to the latest

Delete `Gemfile.lock` and [build the image](#build-this-image). It will
(bundle) install the latest gems in accordance with `Gemfile`.

Then run the container empty to re-generate `Gemfile.lock`.
```
docker run --rm -v ${PWD}:/srv/jekyll -u $(id -u):$(id -g) jekyll
```


### Build or serve a blog

Build blog:
```
docker run --rm -v ${PWD}:/srv/jekyll -u $(id -u):$(id -g) jekyll build
```

Serve blog:
```
docker run --rm -v ${PWD}:/srv/jekyll -u $(id -u):$(id -g) -p 4000:4000 \
    jekyll serve --host 0.0.0.0
```

