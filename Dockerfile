FROM ubuntu:xenial

# TODO: Fold the update with the install once this has stabilized
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update --quiet && \
    apt-get install --quiet --yes software-properties-common openssh-client git
RUN add-apt-repository --yes ppa:fish-shell/release-3 && \
    apt-get update --quiet -y && \
    apt-get install --quiet --yes fish=3.4.0-1~xenial

SHELL ["fish", "--command"]

RUN chsh -s /usr/bin/fish

ENV SHELL /usr/bin/fish
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

ENTRYPOINT [ "fish" ]

RUN apt-get update --quiet -y  
RUN apt-get install --quiet -y \
   curl \
   dnsutils \
   jq \
   netcat

RUN alias k=kubectl
RUN alias ll="ls -latr"

CMD [ "sleep", "infinity" ]  # Overridable in yaml