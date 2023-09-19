apt-get update -y
apt-get install -y openssh-client rsync

eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# The instance ip address is 18.134.252.24
# we should probably avoid hardcoding this, in case
# the IP changes
rsync -av -e "ssh -o StrictHostKeyChecking=no" ./* ec2-user@$INSTANCE_IP_ADDRESS:/var/acebook/
ssh -o StrictHostKeyChecking=no ec2-user@$INSTANCE_IP_ADDRESS "sudo systemctl restart acebook"