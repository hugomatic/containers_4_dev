FROM ubuntu:20.04

# Avoid prompts from commands
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y python3 python3-pip vim tmux && rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file
COPY src/requirements.txt .

# Install the dependencies from the requirements file
RUN pip install -r requirements.txt

# Copy the main.py file
COPY src/main.py .

# Set the entry point to python3 followed by your script name
# This will be the default executable
ENTRYPOINT ["/bin/bash"]


