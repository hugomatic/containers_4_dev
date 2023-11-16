
ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ch5_ssh_container)

echo "the ip of ch5_ssh_container is $ip"
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ./the_ssh_key ubuntu@$ip
