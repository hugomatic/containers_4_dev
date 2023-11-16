
# generate an ssh key
ssh-keygen -t rsa -b 4096 -f ./the_ssh_key

# build the container. It will contain the key
docker build -t ch5_ssh_image .
