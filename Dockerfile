FROM ubuntu:xenial

# TODO: Fold the update with the install once this has stabilized
RUN apt-get update -y  
RUN apt-get install -y curl dnsutils netcat

CMD [ "sleep", "infinity" ]  # Overridable in yaml