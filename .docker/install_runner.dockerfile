FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

# Create non-root user:group and generate a home directory to support SSH
ARG USERNAME
RUN adduser --disabled-password --gecos '' ${USERNAME} \
    && adduser ${USERNAME} sudo                        \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Run container as non-root user from here onwards
# so that build output files have the correct owner
USER ${USERNAME}

# set up volumes
VOLUME /scripts/target

RUN echo "cd /scripts/target" >>  ~/.bashrc

CMD ["/bin/bash"]