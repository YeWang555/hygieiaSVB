#!/bin/bash

if [ "$SKIP_PROPERTIES_BUILDER" = true ]; then
  echo "Skipping properties builder"
  exit 0
fi

# mongo container provides the HOST/PORT
# api container provided DB Name, ID & PWD

if [ "$TEST_SCRIPT" != "" ]
then
  #for testing locally
  PROP_FILE=application.properties
else
  PROP_FILE=/hygieia/config/application.properties
fi

echo "MONGODB_HOST: $MONGODB_HOST"
echo "MONGODB_PORT: $MONGODB_PORT"

cat > $PROP_FILE <<EOF
#Database Name
dbname=${MONGODB_DATABASE:-dashboarddb}
dbhost=${MONGODB_HOST:-db}
dbport=${MONGODB_PORT:-27017}
dbusername=${MONGODB_USERNAME:-dashboarduser}
dbpassword=${MONGODB_PASSWORD:-dbpassword}

#Collector schedule (required)
gitlab.cron=${GITLAB_CRON:-0 0/5 * * * *}

#Gitlab host (optional, defaults to "gitlab.com")
gitlab.host=${GITLAB_HOST:-}

#Gitlab protocol (optional, defaults to "http")
gitlab.protocol=${GITLAB_PROTOCOL:-}

#Gitlab port (optional, defaults to protocol default port)
gitlab.port=${GITLAB_PORT:-}

#Gitlab path (optional, defaults to no path)
gitlab.path=${GITLAB_PATH:-}
  
#Gitlab API Token (required, access token can be retrieved through gitlab, collector will have the permissions of the user associated to the token)
gitlab.apiToken=${GITLAB_API_TOKEN:-}

#Maximum number of days to go back in time when fetching commits
gitlab.firstRunHistoryDays=${GITLAB_COMMIT_THRESHOLD_DAYS:-15}

#Gitlab Instance using self signed certificate
gitlab.selfSignedCertificate=${GITLAB_SELF_SIGNED_CERTIFICATE:-false}

#Gitlab API Version (optional, defaults to current version of 4)
gitlab.apiVersion=${GITLAB_API_VERSION:-4}

EOF

echo "

===========================================
Properties file created `date`:  $PROP_FILE
Note: passwords hidden
===========================================
`cat $PROP_FILE |egrep -vi password`
 "

exit 0
