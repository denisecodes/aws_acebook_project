echo "hello team dragonfly"
echo "$INSTANCE_IP_ADDRESS_1"
echo "$INSTANCE_IP_ADDRESS_2"
echo "$SSH_PRIVATE_KEY"
sudo apt-get update -y
sudo apt-get install -y openssh-client rsync

eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
mkdir -p ~/.ssh
chmod 700 ~/.ssh


rsync -av -e "ssh -o StrictHostKeyChecking=no" ./* ec2-user@$INSTANCE_IP_ADDRESS_1:/var/acebook/
ssh -o StrictHostKeyChecking=no ec2-user@$INSTANCE_IP_ADDRESS_1 "sudo systemctl restart acebook"
rsync -av -e "ssh -o StrictHostKeyChecking=no" ./* ec2-user@$INSTANCE_IP_ADDRESS_2:/var/acebook/
ssh -o StrictHostKeyChecking=no ec2-user@$INSTANCE_IP_ADDRESS_2 "sudo systemctl restart acebook"