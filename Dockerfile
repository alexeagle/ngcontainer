FROM node:6.11.3

###
# Upgrade yarn to 1.0 (node:6.11.3 comes with yarn 0.27.5)
RUN rm -rf /usr/local/bin/yarn /opt/yarn \
 && wget -q -O - http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get install -y yarn

###
# Chrome and xvfb for browser testing
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
 && apt-get update \
 && apt-get install -y \
    google-chrome-stable \
    xvfb \
 && rm -rf /var/lib/apt/lists/*

###
# Java install
# See https://github.com/docker-library/openjdk/blob/415b0cc42d91ef5d70597d8a24d942967728242b/8-jdk/Dockerfile
ENV JAVA_DEBIAN_VERSION 8u131-b11-1~bpo8+1
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20161107~bpo8+1
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \
 && apt-get update \
 && apt-get install -y \
    openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" \
	ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
 && rm -rf /var/lib/apt/lists/*

###
# Bazel install
# See https://bazel.build/versions/master/docs/install-ubuntu.html#using-bazel-custom-apt-repository-recommended
RUN wget -q -O - https://bazel.build/bazel-release.pub.gpg | apt-key add - \
 && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" > /etc/apt/sources.list.d/bazel.list \
 && apt-get update \
 && apt-get install -y \
    bazel \
 && rm -rf /var/lib/apt/lists/*

###
# Brotli compression
# Not available on backports so we have to pull from Debian 9
# See https://packages.debian.org/search?keywords=brotli
RUN echo "deb http://deb.debian.org/debian stretch main contrib" > /etc/apt/sources.list.d/stretch.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    brotli/stretch

ENTRYPOINT ["/bin/bash"]
