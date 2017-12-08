# ngcontainer

This docker container provides everything needed to build and test Angular applications:

- node 8.9.2
- npm 5.5.1
- yarn 1.3.2
- Java 8 (for Closure Compiler and Bazel)
- Bazel build tool v0.8.1 - http://bazel.build
- Google Chrome 63.0.3239.84
- Mozilla Firefox 47.0.1
- xvfb (virtual framebuffer) for headless testing
- Brotli compression utility, making smaller files than gzip

By using this, you avoid installation steps in your CI scripts and get a more consistent dev environment.

## Example

See https://github.com/angular/closure-demo/blob/master/.circleci/config.yml
where this container is used in CircleCI.

To run locally:

```
$ docker run -it --rm angular/ngcontainer
```

## Running tests

Any program that needs to talk to a browser (eg. protractor) should be run under xvfb when executing on a headless machine like on CI. The nice way to factor this is to have your top-level test command which you run locally:

```
$ yarn test
```

Then in your CI configuration, you'd run

```
$ xvfb-run -a yarn test
```
