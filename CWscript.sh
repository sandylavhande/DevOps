#!/bin/bash
set -x
touch log_file
log_file="/ec2-user/script.sh/log_file"

exec &>> "$log_file"

servstat=$(service httpd status)
Servicename="Apache"
AWS_CLI_CMD="aws cloudwatch put-metric-data --region us-east-1"

if [[ $servstat == *"active (running)"* ]]; then
 
  $AWS_CLI_CMD --namespace "ApacheServerStatus" --metric-name "ServerStatus" --value 1 --dimensions "Service=$Servicename"
else

  $AWS_CLI_CMD --namespace "ApacheServerStatus" --metric-name "ServerStatus" --value 0 --dimensions "Service=$Servicename"
fi

set +x


#install Apache server
# install crontab
# install 
#install CWAgent
#create iam usser for cw full access and with credentials for aws configure
# */1 * * * * /bin/bash /home/ec2-user/script.sh
