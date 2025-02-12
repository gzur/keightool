FROM python:3.11-slim

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

# Install core requirements 
RUN apt-get update --quiet && \
    apt-get install --quiet --yes \
        software-properties-common \
        openssh-client \
        git \
        curl \
        dnsutils \
        jq \
        netcat-traditional \
        tcpdump \
        redis-tools \
        postgresql-client \
        vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY VERSION /VERSION

CMD ["sleep", "infinity"]