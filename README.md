# ngcontainer

This docker container provides everything needed to build and test Angular applications:

- Node, npm, and yarn
- Java 8 (for Closure Compiler and Bazel)
- Bazel build tool - http://bazel.build
- Google Chrome browser and xvfb (virtual framebuffer) for headless testing
- Brotli compression utility, making smaller files than gzip

By using this, you avoid installation steps in your CI scripts and get a more consistent dev environment.

## Example

See https://github.com/angular/closure-demo/blob/master/.circleci/config.yml
where this container is used in CircleCI.

To run locally:

```
$ docker run -it --rm alexeagle/ngcontainer
```

## Running tests

Any program that needs to talk to a browser (eg. protractor) should be run under xvfb when executing on a headless machine like on CI. The nice way to factor this is to have your top-level test command which you run locally:

```
$ yarn tst
```

Then in your CI configuration, you'd run

```
$ xvfb-run -a yarn test
```
