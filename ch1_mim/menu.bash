#!/bin/bash

echo "Select a Docker command to execute:"
echo -e "\e[32m1) Run a terminal in a container\e[0m"
echo "   docker run -it --rm --name <container name> <image name> /bin/bash"
echo -e "\e[32m2) Remove an image\e[0m"
echo "   docker rmi <image name>"
echo -e "\e[32m3) Share a volume\e[0m"
echo "   docker run -it --rm --name <container name> -v <local path>:/share <image name> /bin/bash"
echo -e "\e[32m4) Stop a container\e[0m"
echo "   docker stop <container name>"
echo -e "\e[32m5) Delete a container\e[0m"
echo "   docker rm <container name>"
echo -e "\e[32m6) Attach to a running container\e[0m"
echo "   docker attach <container name>"
echo -e "\e[32m7) Execute a new terminal in a container\e[0m"
echo "   docker exec -ti <container name> bash"
echo -e "\e[32m8) Copy files in/out of container\e[0m"
echo "   docker cp <container name>:<path> <local_path>"
echo -e "\e[32m9) List Docker images\e[0m"
echo "   docker images"
echo -e "\e[32m10) List running containers (-a for all)\e[0m"
echo "   docker ps -a"
read -p "Enter your choice (1-10): " choice

case $choice in
  1) read -p "Enter container name [ch1_container]: " cname
     cname=${cname:-ch1_container}
     read -p "Enter image name [ubuntu:23.04]: " iname
     iname=${iname:-ubuntu:23.04}
     docker run -it --rm --name $cname $iname /bin/bash ;;
  2) read -p "Enter image name to remove: " imgname
     docker rmi $imgname ;;
  3) read -p "Enter container name [ch1_container]: " cname
     cname=${cname:-ch1_container}
     read -p "Enter local path: " lpath
     read -p "Enter image name [ubuntu:23.04]: " iname
     iname=${iname:-ubuntu:23.04}
     docker run -it --rm --name $cname -v $lpath:/share $iname /bin/bash ;;
  4) read -p "Enter container name to stop [ch1_container]: " cname
     cname=${cname:-ch1_container}
     docker stop $cname ;;
  5) read -p "Enter container name to delete [ch1_container]: " cname
     cname=${cname:-ch1_container}
     docker rm $cname ;;
  6) read -p "Enter container name to attach [ch1_container]: " cname
     cname=${cname:-ch1_container}
     docker attach $cname ;;
  7) read -p "Enter container name for new terminal [ch1_container]: " cname
     cname=${cname:-ch1_container}
     docker exec -ti $cname bash ;;
  8) read -p "Enter 'container_name:path' and 'local_path' separated by space [ch1_container:path local_path]: " containerpath localpath
     docker cp $containerpath $localpath ;;
  9) docker images ;;
  10) docker ps -a ;;
  *) echo "Invalid option"; exit 1 ;;
esac

