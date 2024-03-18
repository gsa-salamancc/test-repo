#!/bin/sh

NAME=""
DESCRIPTION=""
PREFIX=""
TEAM=""
ENV=""
TYPE="API_PROVIDER"
ACCESS_TOKEN=""
URL="http://localhost:8080/v1.0/registrations/products"

while getopts "n:d:p:t:e:a:" opt; do
  case ${opt} in
    n ) NAME=$OPTARG ;;
    d ) DESCRIPTION=$OPTARG ;;
    p ) PREFIX=$OPTARG ;;
    t ) TEAM=$OPTARG ;;
    e ) ENV=$OPTARG ;;
    a ) ACCESS_TOKEN=$OPTARG ;;
    \? ) echo "Usage: cmd [-n name] [-d description] [-p prefix] [-t team] [-e env] [-a access_token]" #[-u url]"
         exit 1 ;;
  esac
done

if [ -z "$NAME" ] || [ -z "$DESCRIPTION" ] || [ -z "$PREFIX" ] || [ -z "$TEAM" ] || [ -z "$ENV" ] || [ -z "$ACCESS_TOKEN" ]; then
    echo "All parameters are required."
    echo "Usage: cmd [-n name] [-d description] [-p prefix] [-t team] [-e env] [-a access_token]"
    exit 1 
fi

JSON_PAYLOAD=$(cat <<EOF
{
    "name": "$NAME",
    "description": "$DESCRIPTION",
    "prefix": "$PREFIX",
    "team": "$TEAM",
    "env": "$ENV",
    "type": "$TYPE"
}
EOF
)

echo "\\n Registered Product Response:\\n"
RES=$(curl -X POST "$URL" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $ACCESS_TOKEN" \
-d "$JSON_PAYLOAD")
echo $RES | jq '.' 