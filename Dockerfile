ARG RUBY_VERSION=3.1.4
ARG VARIANT=jemalloc-slim
FROM ghcr.io/blish/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

# RUN with pipe recommendation: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
      fonts-liberation \
      libasound2 \
      libatk-bridge2.0-0 \
      libatk1.0-0 \
      libatspi2.0-0 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libdrm2 \
      libgbm1 \
      libglib2.0-0 \
      libgtk-3-0 \
      libnspr4 \
      libnss3 \
      libpango-1.0-0 \
      libu2f-udev \
      libvulkan1 \
      libx11-6 \
      libxcb1 \
      libxcomposite1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxkbcommon0 \
      libxrandr2 \
      wget \
      xdg-utils \
    && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists \
    && rm -fr /var/cache/apt

CMD [ "google-chrome", "-v" ]
