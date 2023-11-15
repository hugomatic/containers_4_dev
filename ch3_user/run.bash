docker run --rm -ti \
           -e HOST_UID=$(id -u) \
           -e HOST_GID=$(id -g) \
           -e HOST_USERNAME=$(whoami) \
           -e HOST_GROUPNAME=$(id -gn)  \
           --volume "$(pwd)/src:/src" \
           ch3_user_image
