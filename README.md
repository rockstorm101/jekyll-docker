Jekyll on Docker
================

Instructions to generate a customized Docker image to use [Jekyll][1] to build
(and serve) your website.

 * Why yet another Docker image for Jekyll? Because the [official image][2]
   seems unmaintained and it felt way too complicated. By generating a
   customized image this way, next container runs won't need to download or
   install anything else and therefore will be way faster.

 * Why need Docker? So you don't need to pollute your system with Ruby cruft.


[1]: https://jekyllrb.com/
[2]: https://github.com/envygeeks/jekyll-docker


Basic Workflow
--------------
### 1. Build your custom Docker image

Copy this [`Dockerfile`](Dockerfile), place it next to your `Gemfile.lock` (or
`Gemfile`) and build your custom Jekyll Docker image. It will (bundle) install
the gems at the specified versions (or the latest ones possible).

```
docker build -t jekyll .
```

> If you don't have a `Gemfile` see [Starting a blog from
> scratch](#starting-a-blog-from-scratch).

> If the building fails you might need to install additional packages to build
> certain gems. See [Additional Packages](#additional-packages).


### 2. Build / Serve your blog

Build:
```
docker run --rm \
    -v ${PWD}:/srv/jekyll \
	-u $(id -u):$(id -g) \
	jekyll build
```

Serve[^1]:
```
docker run --rm \
    -v ${PWD}:/srv/jekyll \
    -u $(id -u):$(id -g) \
    -p 4000:4000 \
    jekyll serve --host 0.0.0.0
```

> If you use Podman instead of Docker, simply replace `docker` with `podman`
> in the commands above and you can omit the `-u $(id -u):$(id -g)` bit.

> Note that the `--host 0.0.0.0` bit is important for serving to be able to
> access your blog from outside the container.


Alternative Workflows
---------------------
### Starting a blog from scratch

 1. Copy this [`Dockerfile`](Dockerfile) and the default [`Gemfile`](Gemfile)
    on a directory (e.g. `jekyll-docker`) and build a preliminary Docker image.
    ```
	git clone https://github.com/rockstorm101/jekyll-docker.git
	cd jekyll-docker
    docker build -t jekyll .
    ```

 2. Create a new Jekyll site:
    ```
	docker run --rm \
	    -v ${PWD}:/srv/jekyll \
		-u $(id -u):$(id -g) \
		jekyll new myblog
    ```

 3. The previous step should have produced a new fresh Jekyll site at
    `./myblog` which includes a `Gemfile`. Now you can proceed as per the
    [Basic Worflow](#basic-workflow).


### Add or Update Gems

 1. Update your `Gemfile` with new/updated dependencies.

 2. Delete `Gemfile.lock` and [(re)build your custom Docker
    image](#1-build-your-custom-docker-image) as normal. It will (bundle)
    install the latest gems in accordance with your updated `Gemfile`.

 3. Run the container empty to re-generate the `Gemfile.lock`.
    ```
    docker run --rm \
        -v ${PWD}:/srv/jekyll \
        -u $(id -u):$(id -g) \
        jekyll
    ```


### Additional Packages

Certain gems require additional system packages in order to be installed or
run. This can be achieved by adding a file named `packages` to your context
with a list of packages that need to be installed.

TODO: If you used any of the `builder`, `standard` or `minimal` [official
images][2] before you might want to use one of the example `packages` files
provided.


### GitHub Pages

Using the `Gemfile` at `examples/github-pages` will produce a custom image
configured exactly as is used by [GitHub Pages][3].

[3]: https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll


License
-------
View [license information](LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may
be under other licenses (such as Ruby or Jekyll) from the base distribution,
along with any direct or indirect dependencies of the primary software being
contained.

It is the container user's responsibility to ensure that any use of their
images complies with any relevant licenses for all software contained within.


[^1]: Serving this way should only be done for development purposes. For
    production see documentation on [deployment][4]


[4]: https://jekyllrb.com/docs/deployment/
