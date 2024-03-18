#!/bin/sh

# Initialize variables
NAME=""
LAST=""
DEPARTMENT=""
LOCATION=""
POSITION=""
ACCESS_TOKEN=""
URL="http://localhost:8080/v1.0/registrations/clients"

# Parse command line options
while getopts "n:d:p:a:" opt; do
  case ${opt} in
    n ) NAME=$OPTARG ;;
    d ) LAST=$OPTARG ;;
    p ) DEPARTMENT=$OPTARG ;;

    a ) ACCESS_TOKEN=$OPTARG ;;
    \? ) echo "Usage: cmd [-n first name] [-d last name] [-p department] [-a access_token]" 
         exit 1 ;;
  esac
done

if [ -z "$NAME" ] || [ -z "$LAST" ] || [ -z "$DEPARTMENT" ] || [ -z "$ACCESS_TOKEN" ]; then 
    echo "All parameters are required."
    echo "Usage: cmd [-n first name] [-d last name] [-p department] [-a access_token]" 
    exit 1 
fi

# Constructing the JSON payload from the input variables
JSON_PAYLOAD=$(cat <<EOF
{
    "firstName": "$NAME",
    "lastName": "$LAST",
    "department": "$DEPARTMENT"
}
EOF
)

echo "\\n Registered Client:\\n"
RES=$(curl -X POST "$URL" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $ACCESS_TOKEN" \
-d "$JSON_PAYLOAD")
echo $RES | jq '.' 