#!/usr/bin/env bash

apt-get install jq curl -y

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install -y ${ecs_docker_version}

# setup ecs agent iptables
sh -c "echo 'net.ipv4.conf.all.route_localnet = 1' >> /etc/sysctl.conf"
sysctl -p /etc/sysctl.conf
iptables -t nat -A PREROUTING -p tcp -d 169.254.170.2 --dport 80 -j DNAT --to-destination 127.0.0.1:51679
iptables -t nat -A OUTPUT -d 169.254.170.2 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 51679
mkdir -p /etc/iptables
sh -c 'iptables-save > /etc/iptables/rules.v4'
mkdir -p /etc/ecs && touch /etc/ecs/ecs.config
  
# configure ecs
cat <<EOF > /etc/ecs/ecs.config
ECS_DATADIR=/data
ECS_ENABLE_TASK_IAM_ROLE=true
ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true
ECS_LOGFILE=/log/ecs-agent.log
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
ECS_LOGLEVEL=info
ECS_CLUSTER=${ecs_cluster_name}
EOF
  
mkdir -p /var/log/ecs /var/lib/ecs/data
  
docker run --name ecs-agent \
--detach=true \
--restart=unless-stopped \
--volume=/var/run:/var/run \
--volume=/var/log/ecs/:/log \
--volume=/var/lib/ecs/data:/data \
--volume=/etc/ecs:/etc/ecs \
--net=host \
--env-file=/etc/ecs/ecs.config \
amazon/amazon-ecs-agent:latest

# remainder of Argo bootstrap
if [ "${real_customer}" == "none" ]; then
REAL_CUSTOMER=${customer}
else
REAL_CUSTOMER=${real_customer}
fi

IFS=',' read -r -a array <<< "${products}"

products2="["
for element in "$${array[@]}"
do
  IFS=':' read -r -a array2 <<< "$$element"
  products2+="{\"name\":\"$${array2[0]}\",\"environment\":\"$${array2[1]}\"},"
done

products2=$${products2%?}

products2+="]"

curl -X POST -H "Content-Type: application/json" -v -o /tmp/bootstrap.sh http://${bootstrap_endpoint}/v1/get_bootstrap_text --data-binary @- <<BODY
{
  "chassis": "${chassis}",
  "package": "${package_size}",
  "location": "${location}",
  "owner": "${owner}",
  "customer": "$${REAL_CUSTOMER}",
  "network": "${network}",
  "conftag": "${conftag}",
  "creator": "terraform",
  "lvm": "${lvm}",
  "mkfs": "${mkfs}",
  "nameservers": "${nameservers}",
  "ntpservers": "${ntpservers}",
  "idburl": "${idb_endpoint}",
  "idbrwurl": "${idb_rw_endpoint}",
  "deployiturl": "${deployit_endpoint}",
  "products": $${products2}
}
BODY

bash /tmp/bootstrap.sh
