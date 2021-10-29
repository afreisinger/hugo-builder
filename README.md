# Hugo Docker Image

[Hugo](https://gohugo.io/) is a fast and flexible static site generator, written in Go.
Hugo flexibly works with many formats and is ideal for blogs, docs, portfolios and much more.
Hugo’s speed fosters creativity and makes building a website fun again.

This Lightweight Docker Image is based on Alpine, and comes with rsync for Continuous Deployment.

## Get Started

Print Hugo Help:

```bash
docker run --rm -it afreisinger/hugo-builder hugo help
```

Create a new Hugo managed website:

```bash
docker run --rm -it -v $PWD:/src -u hugo afreisinger/hugo-builder hugo new site mysite
cd mysite

# Now, you probably want to add a theme (see https://themes.gohugo.io/):
git init
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke;
echo 'theme = "ananke"' >> config.toml
```

Add some content:

```bash
docker run --rm -it -v $PWD:/src -u hugo afreisinger/hugo-builder hugo new posts/my-first-post.md

# Now, you can edit this post, add your content and remove "draft" flag:
vim content/posts/my-first-post.md
```

Build your site:

```bash
docker run --rm -it -v $PWD:/src -u hugo afreisinger/hugo-builder hugo
```

Serve your site locally:

```bash
docker run --rm -it -v $PWD:/src -p 1313:1313 -u hugo afreisinger/hugo-builder hugo server -w --bind=0.0.0.0
```

Then open [`http://localhost:1313/`](http://localhost:1313/) in your browser.

To go further, read the [Hugo documentation](https://gohugo.io/documentation/).

## Bash Alias

For ease of use, you can create a bash alias:

```bash
alias hugo='docker run --rm -it -v $PWD:/src -u hugo afreisinger/hugo-builder hugo'
alias hugo-server='docker run --rm -it -v $PWD:/src -p 1313:1313 -u hugo afreisinger/hugo-builder hugo server --bind 0.0.0.0'
```

Now, you can use `hugo help`, `hugo new foo/bar.md`, `hugo-server -w`, etc.

## A simple and clean blog example [Coder theme](https://themes.gohugo.io/themes/hugo-coder/) for [Hugo](https://gohugo.io/)

```text
hugo new site johndoe
cd johndoe
git init
git submodule add https://github.com/luizdepra/hugo-coder.git themes/hugo-coder
hugo --themesDir=../.. --source=themes/hugo-coder/exampleSite
hugo-server -w --themesDir=../.. --source=themes/hugo-coder/exampleSite
```

Remember, then open [`http://localhost:1313/`](http://localhost:1313/) in your browser.

## Users

By default, this docker image run as the root user. This makes it easy to use as base image for other Dockerfiles (switching back and forth adds extra layers and is against the current [best practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#user) advised by Docker). Most (all official?) base images leave the default user as root.

However, this docker image also define a non-root user `hugo` (UID 1000, GID 1000) which can be switched on at run time using the `--user` flag to `docker run`.

```bash
docker run --rm -it -v $PWD:/src --user hugo afreisinger/hugo-builder hugo
```

You can also change this according your needs, by setting another UID/GID. For instance, to run hugo with user `www-data:www-data` (UID 33, GID 33) :

```bash
docker run --rm -it -v $PWD:/src -u 33:33 afreisinger/hugo-builder hugo
```

## Issues

If you have any problems with or questions about this docker image, please contact me through a [GitHub issue](https://github.com/afreisinger/hugo-builder/issues).
If the issue is related to Hugo itself, please leave an issue on the [Hugo official repository](https://github.com/spf13/hugo).

## Contributing

You are invited to contribute new features, fixes or updates to this container, through a [Github Pull Request](https://github.com/afreisinger/hugo-builder/pulls).