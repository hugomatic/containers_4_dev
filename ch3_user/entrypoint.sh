#!/bin/bash

# Fetch the UID, GID, username, and group name of the Docker user
HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}
HOST_USERNAME=${HOST_USERNAME:-appuser}
HOST_GROUPNAME=${HOST_GROUPNAME:-appgroup}

# Create a new group with the fetched GID and name
if ! getent group $HOST_GID > /dev/null 2>&1; then
    groupadd -g $HOST_GID $HOST_GROUPNAME
else
    HOST_GROUPNAME=$(getent group $HOST_GID | cut -d: -f1)
fi

# Create a new user with the fetched UID/GID and add it to the sudo group
if ! getent passwd $HOST_UID > /dev/null 2>&1; then
    useradd --shell /bin/bash -u $HOST_UID -g $HOST_GID -m -o -c "" $HOST_USERNAME
else
    HOST_USERNAME=$(getent passwd $HOST_UID | cut -d: -f1)
    usermod -l $HOST_USERNAME $(getent passwd $HOST_UID | cut -d: -f1)
    usermod -g $HOST_GID $HOST_USERNAME
fi

# Set home directory
export HOME=/home/$HOST_USERNAME

# Grant the user passwordless sudo privileges
echo "$HOST_USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$HOST_USERNAME

# Ensure correct permissions on the home directory
chown $HOST_USERNAME:$HOST_GROUPNAME $HOME

# Execute the command passed to the docker run command
exec gosu $HOST_USERNAME "$@"

