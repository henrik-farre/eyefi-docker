####################################################
#
# Based on https://github.com/sbma44/eyefi-docker
#
####################################################
FROM debian:stretch-slim

# Hardcoded to only support one key, just spin another container up for another card
ENV GEOTAG_ENABLE=1 \
    GEOTAG_LAG=3600 \
    GEOTAG_ACCURACY=140000 \
    MAC=000000000001 \
    UPLOAD_KEY=11111111111111111111111111111111

EXPOSE 59278

ENTRYPOINT [ "python", "eyefiserver.py" ]

RUN mkdir -p /upload \
    && apt-get update -y \
    && apt-get -q -y --no-install-recommends install python \
    && rm -rf /var/lib/apt/lists/* /var/cache /var/lib/dpkg/info

ADD eyefiserver.py .

ARG VCS_REF="local"
ARG VCS_URL="none"
ARG VERSION="dev"
LABEL org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.vcs-url="$VCS_URL" \
      org.label-schema.version="$VERSION" \
      maintainer="henrik@rockhopper.dk"
