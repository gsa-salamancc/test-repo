#!/bin/sh

# Assign the command line arguments to variables
CLIENT_ID=$1
CLIENT_SECRET=$2
SCOPE=$3

# Use curl to make a www-form-urlencoded request
JWT=$(curl -X POST https://login.microsoftonline.com/1abaa44d-2d93-433d-80c0-74d6809054b2/oauth2/v2.0/token \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&scope=$SCOPE&grant_type=client_credentials")
echo "JWT Token"
echo "-----"
echo $JWT | jq -r '.'
echo "-----"
