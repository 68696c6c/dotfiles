#!/bin/bash
set -eu
account=352747369312
email=aaron.hill@shift.com

# Gets an AWS session token for the ops profile.
function awsmfa() {
  resp=$(docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli sts get-session-token --serial-number arn:aws:iam::$account:mfa/$email --token-code $2 --duration-seconds 129600 --output text --profile $1 | awk -F "\t" '{print $2; print $4; print $5; }')
  read -r KEY_ID SECRET_KEY SESSION_KEY <<< $(echo $resp)

  cat << EOF > ~/.aws/credentials
[default]
aws_access_key_id = $KEY_ID
aws_secret_access_key = $SECRET_KEY
aws_session_token = $SESSION_KEY
EOF

  cat ~/.aws/base-creds >> ~/.aws/credentials
}

# Echo out the current profile.
function aws_prof() {
  local profile="${CURRENT_DEFAULT_AWS_PROFILE:=default}"
  echo $profile
}

# Overwrites the .aws/credentials file with the specified profile from the
# .aws/base-creds file.
function ap() {
    echo "[default]" > ~/.aws/credentials
    awk "/\[$1/,/^$/" ~/.aws/base-creds | sed '1d' >> ~/.aws/credentials
    cat ~/.aws/base-creds >> ~/.aws/credentials

    export CURRENT_DEFAULT_AWS_PROFILE=$1
    echo $CURRENT_DEFAULT_AWS_PROFILE

    awsmfa $1 $2

    docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli sts get-caller-identity
}

ap $1 $2
