ARG RUBY_VERSION=3.1.4
ARG VARIANT=jemalloc-slim
FROM ghcr.io/blish/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

# RUN with pipe recommendation: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -SLf "https://dl.google.com/linux/linux_signing_key.pub" | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
      build-essential \
      git \
      google-chrome-stable \
      imagemagick \
      libpq-dev \
      postgresql-client \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists \
    && rm -rf /var/cache/apt

ARG NODE_VERSION=16
ARG YARN_VERSION=1.22.19

RUN curl https://get.volta.sh | bash
ENV VOLTA_HOME /root/.volta
ENV PATH $VOLTA_HOME/bin:/usr/local/bin:$PATH
RUN volta install node@${NODE_VERSION} yarn@${YARN_VERSION}

RUN gem install bundler --no-document

CMD ["/bin/bash"]
