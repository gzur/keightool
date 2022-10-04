FROM ubuntu:xenial

# TODO: Fold the update with the install once this has stabilized
ARG DEBIAN_FRONTEND=noninteractive

# Install core requirements
RUN apt-get update --quiet && \
    apt-get install --quiet --yes \
        software-properties-common \
        openssh-client \
        git \
        fish

SHELL ["fish", "--command"]

RUN chsh -s /usr/bin/fish

ENV SHELL /usr/bin/fish
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

# Install fun things to have inside a k8s container
RUN apt-get update --quiet -y  
RUN apt-get install --quiet -y \
        curl \
        dnsutils \
        jq \
        netcat \        
        tcpdump 

RUN alias k=kubectl
RUN alias ll="ls -latr"

COPY VERSION /VERSION
CMD [ "sleep", "infinity" ]  # Overridable in yaml