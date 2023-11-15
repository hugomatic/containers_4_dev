FROM ubuntu:22.04

# Avoid prompts from commands
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    sudo gosu\
    python3 \
    python3-pip \
    vim \
    tmux && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /src

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Set the script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]


