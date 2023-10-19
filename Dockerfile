# Use the official Ubuntu image as the parent image
FROM ubuntu:latest

# Set environment variables to non-interactive (to avoid prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH, sudo, and any other necessary utilities
RUN apt-get update && apt-get install -y openssh-server sudo net-tools && rm -rf /var/lib/apt/lists/*

# Create the necessary directory for SSHD
RUN mkdir /var/run/sshd

# Create a new system user (we're using 'ubuntu' here)
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu

# Set the password for the 'ubuntu' user (change 'your_password' to a secure password)
RUN echo 'ubuntu:your_password' | chpasswd

# Adjust SSH configuration to allow password authentication
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#*PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Expose the SSH port
EXPOSE 22

# Switch to 'ubuntu' user
USER ubuntu

# Create .ssh directory
RUN mkdir -p /home/ubuntu/.ssh && \
    chmod 700 /home/ubuntu/.ssh

# Generate ssh keys for 'ubuntu' user
RUN ssh-keygen -t rsa -b 4096 -f /home/ubuntu/.ssh/id_rsa -N ""

RUN cat /home/ubuntu/.ssh/id_rsa

# Ensure proper permissions
RUN chmod 600 /home/ubuntu/.ssh/id_rsa && \
    chmod 600 /home/ubuntu/.ssh/id_rsa.pub

# Switch back to root if further root actions are needed
USER root

# Start SSH server in the foreground and display necessary information
CMD /usr/sbin/sshd -D
