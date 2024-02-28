#
# Base Webdriver Dockerfile
#

FROM debian:bookworm-slim

# Install the base requirements to run and debug webdriver implementations:
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install --no-install-recommends --no-install-suggests -y \
    xvfb \
    xauth \
    ca-certificates \
    x11vnc \
    fluxbox \
    rxvt-unicode \
    curl \
    tini \
  # Remove obsolete files:
  && apt-get clean \
  && rm -rf \
    /tmp/* \
    /usr/share/doc/* \
    /var/cache/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# Patch xvfb-run to support TCP port listening (disabled by default):
RUN sed -i 's/LISTENTCP=""/LISTENTCP="-listen tcp"/' /usr/bin/xvfb-run

# Avoid permission issues with host mounts by assigning a user/group with
# uid/gid 1000 (usually the ID of the first user account on GNU/Linux):
RUN useradd -u 1000 -m -U webdriver

WORKDIR /home/webdriver

COPY entrypoint.sh /usr/local/bin/entrypoint
COPY vnc-start.sh /usr/local/bin/vnc-start

# Configure Xvfb via environment variables:
ENV SCREEN_WIDTH 1440
ENV SCREEN_HEIGHT 900
ENV SCREEN_DEPTH 24
ENV DISPLAY :0

ENTRYPOINT ["entrypoint"]
