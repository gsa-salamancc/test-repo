#!/bin/sh

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
    \? ) echo "Usage: cmd [-a access_token]"
  esac
done

if [ -z "$ACCESS_TOKEN" ]; then
    echo "All parameters are required."
    echo "Usage: cmd [-a access_token]"
    exit 1 
fi

echo "\\n Registered Product List Response:\\n"
RES=$(curl -X GET "$URL" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $ACCESS_TOKEN")
echo $RES | jq '.' 
