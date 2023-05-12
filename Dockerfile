
FROM debian:bookworm-slim

## Configure Apt
#  * Say "yes" automatically
#  * Never want to install "Recommended" packages
RUN  echo 'APT::Get::Assume-Yes "true";'     > /etc/apt/apt.conf.d/AssumeYes
RUN  echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/NoRecommendations

## Add own Repository
RUN  apt-get update \
  && apt-get install --mark-auto curl \
  && rm -rf /var/lib/apt/lists/*
RUN  curl -o /usr/share/keyrings/s06eye-keyring.gpg https://deb.s06eye.co.uk/repository.gpg
RUN  curl -o /etc/apt/sources.list.d/s06eye.list    https://deb.s06eye.co.uk/bookworm.list

## Install build system dependencies
RUN  apt-get update \
  && apt-get install \
    build-essential \
    ddepextract \
    debhelper \
    devscripts \
    git-buildpackage \
  && rm -rf /var/lib/apt/lists/*

## Cleanup
RUN  apt-get --purge autoremove \
  && apt-get clean
