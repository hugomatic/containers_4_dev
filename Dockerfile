# Use the latest Ubuntu base image
FROM ubuntu:latest

# Install the OpenSSH server and any other necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd

# Create a new user (e.g., 'ubuntu') with a default password
RUN useradd -rm -d /home/ubuntu -s /bin/bash -u 1000 ubuntu && \
    echo 'ubuntu:ubuntu' | chpasswd

# Create the SSH directory for our user
RUN mkdir -p /home/ubuntu/.ssh

# Change the ownership of the .ssh directory to our user
RUN chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# Allow the new user to use SSH
RUN echo 'AllowUsers ubuntu' >> /etc/ssh/sshd_config

# Generate a new SSH key for our user
RUN ssh-keygen -t rsa -f /home/ubuntu/.ssh/id_rsa -q -N "" && \
    cp /home/ubuntu/.ssh/id_rsa.pub /home/ubuntu/.ssh/authorized_keys

# Expose the SSH port
EXPOSE 22

# Start the SSH daemon in the foreground to keep the container running, and print the public key
CMD /usr/sbin/sshd -D -e & \
    echo "SSH public key:" && \
    cat /home/ubuntu/.ssh/id_rsa.pub

