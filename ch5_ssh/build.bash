
# generate an ssh key, override existing and no passphrase
ssh-keygen -t rsa -b 4096 -f ./the_ssh_key -N "" -y

# build the container. It will contain the key
docker build -t ch5_ssh_image .
