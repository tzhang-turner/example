#!/usr/bin/env bash

apt-get install curl -y

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
