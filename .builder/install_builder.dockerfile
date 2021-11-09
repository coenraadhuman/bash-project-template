FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

# Create non-root user:group and generate a home directory to support SSH
ARG USERNAME
RUN adduser --disabled-password --gecos '' ${USERNAME} \
    && adduser ${USERNAME} sudo                        \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
# Install make utility inside docker
RUN apt-get update \
    && apt-get -y --quiet --no-install-recommends install \
       make 

# Run container as non-root user from here onwards
# so that build output files have the correct owner
USER ${USERNAME}

# set up volumes
VOLUME /scripts
VOLUME /workdir

# run bash script and process the input command
ENTRYPOINT [ "/bin/bash", "/scripts/run_build.sh"]
