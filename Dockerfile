
FROM debian:bookworm-slim

## Configure Apt
#  * Say "yes" automatically
#  * Never want to install "Recommended" packages
#  * Remove installed "Recommended" and "Suggested" packages
RUN  echo 'APT::Get::Assume-Yes "true";'                  >  /etc/apt/apt.conf.d/AssumeYes         \
  ;  echo 'APT::Install-Recommends "false";'              >  /etc/apt/apt.conf.d/NoRecommendations \
  ;  echo 'APT::AutoRemove::RecommendsImportant "false";' >> /etc/apt/apt.conf.d/NoRecommendations \
  ;  echo 'APT::AutoRemove::SuggestsImportant "false";'   >  /etc/apt/apt.conf.d/NoSuggestions

## Add own Repository
RUN  apt-get update \
  && apt-get install --mark-auto \
    ca-certificates \
    curl \
  && rm -rf /var/lib/apt/lists/*

RUN  curl -o /usr/share/keyrings/s06eye-keyring.gpg https://deb.s06eye.co.uk/repository.gpg \
  ;  curl -o /etc/apt/sources.list.d/s06eye.list    https://deb.s06eye.co.uk/bookworm.list

## Install build system dependencies
RUN  apt-get update \
  && apt-get install --auto-remove \
    build-essential \
    ddepextract \
    debhelper \
    devscripts \
    git \
    git-buildpackage \
  && rm -rf /var/lib/apt/lists/*
