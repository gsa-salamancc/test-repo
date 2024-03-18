#!/bin/sh

PROVIDER=""
SPEC_URL=""
SPEC_NAME=""
ACCESS_TOKEN=""
URL="http://localhost:8080/v1.0/registrations/products/apis"

while getopts "n:d:s:a:" opt; do
  case ${opt} in
    n ) PROVIDER=$OPTARG ;;
    d ) SPEC_URL=$OPTARG ;;
    s ) SPEC_NAME=$OPTARG ;;
    a ) ACCESS_TOKEN=$OPTARG ;;
    \? ) echo "Usage: cmd [-n provider name] [-d OpenAPI URL] [-s OpenAPI name] [-a access_token]"
  esac
done

if [ -z "$ACCESS_TOKEN" ] || [ -z "$PROVIDER" ] || [ -z "$SPEC_URL" ] || [ -z "$SPEC_NAME" ]; then
    echo "All parameters are required."
    echo "Usage: cmd [-n provider name] [-d OpenAPI URL] [-s OpenAPI name] [-a access_token]"
    exit 1 
fi

JSON_PAYLOAD=$(cat <<EOF
{
    "spName": "$PROVIDER",
    "apiList": [
      {
            "name": "$SPEC_NAME",
            "apiSpecUrl": "$SPEC_URL"
      }
    ]
}
EOF
)

echo "\\n Group API To Product Response:\\n"
RES=$(curl -X PATCH "$URL" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer $ACCESS_TOKEN" \
-d "$JSON_PAYLOAD")
echo $RES | jq '.'./

