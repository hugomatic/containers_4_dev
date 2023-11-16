# Use the desired version of Ubuntu
FROM ubuntu:23.10

# Avoid prompts from commands
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH Server, sudo, and any other necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    net-tools \
    netcat-openbsd \
    vim \
    tmux \
    git \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

# Create the 'ubuntu' group if it doesn't already exist (23.04 and up)
RUN if ! getent group ubuntu >/dev/null; then \
  groupadd -g 1000 ubuntu; \
fi

# Create 'ubuntu' user, set the 'ubuntu' group as primary, give sudo privileges
RUN if ! getent passwd ubuntu >/dev/null; then \
  useradd -rm -d /home/ubuntu -s /bin/bash -g ubuntu -G sudo -u 1000 ubuntu; \
fi


# Set the password for the 'ubuntu' user (optional if using SSH key login)
# RUN echo 'ubuntu:toto1234' | chpasswd  # Replace 'password' with a password of your choice

# Create the necessary folder structure for SSHD (it exists in 23)
RUN mkdir -p /var/run/sshd

# Copy the SSH public key from your host to the authorized_keys file for the 'ubuntu' user
RUN mkdir -p /home/ubuntu/.ssh
COPY the_ssh_key.pub /home/ubuntu/.ssh/authorized_keys

# Create the .ssh directory and authorized_keys file for the 'ubuntu' user
# Switch to root to ensure we have permission for the next operations
# USER root
RUN mkdir -p /home/ubuntu/.ssh && \
    touch /home/ubuntu/.ssh/authorized_keys && \
    chown -R ubuntu:ubuntu /home/ubuntu/.ssh && \
    chmod 700 /home/ubuntu/.ssh && \
    chmod 600 /home/ubuntu/.ssh/authorized_keys


# Expose the SSH port
EXPOSE 22


# Start the SSH daemon
CMD ["/usr/sbin/sshd", "-D"]

