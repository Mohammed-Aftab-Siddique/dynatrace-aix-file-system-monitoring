#!/usr/bin/ksh

# Adjustable variables
DT_TENANT_URL="<Tenant URL with Environment ID"
DT_API_TOKEN="<API-Token with Ingest.Metric permission>"
METRIC_ENDPOINT="$DT_TENANT_URL/api/v2/metrics/ingest"
HOST_IP="<Host IP>"

# Path and permission
PATH=/usr/bin:/bin
export PATH
umask 077

# Creating temp files
TMP_PAYLOAD="/tmp/dt_payload.$$"
> "$TMP_PAYLOAD"

# For -> </path/to/dir1> 
DIR="</path/to/dir1>"

# Fetch file count
set -- "$DIR"/*
FILE_COUNT=$#

# Create payload
echo "custom.file.count.v1,host=${HOST_IP},dir=${DIR} $FILE_COUNT" >> "$TMP_PAYLOAD"

find "$DIR" -type f 2>/dev/null | while read -r FILE
do
  # Extracting the basename of a file
  BASE_FILE=$(basename "$FILE")

  # Create payload
  echo "custom.file.available.v1,filename=${BASE_FILE},host=${HOST_IP},dir=${DIR} 1" >> "$TMP_PAYLOAD"
done


# For -> </path/to/dir2> 
DIR="</path/to/dir2>"

# Fetch file count
set -- "$DIR"/*
FILE_COUNT=$#

# Create payload
echo "custom.file.count.v1,host=${HOST_IP},dir=${DIR} $FILE_COUNT" >> "$TMP_PAYLOAD"

find "$DIR" -type f 2>/dev/null | while read -r FILE
do
  # Extracting the basename of a file
  BASE_FILE=$(basename "$FILE")

  # Create payload
  echo "custom.file.available.v1,filename=${BASE_FILE},host=${HOST_IP},dir=${DIR} 1" >> "$TMP_PAYLOAD"
done

# Note: You can add as many directory blocks as required.

# Ingest to DT
curl -kv -s -X POST "$METRIC_ENDPOINT" -H "Authorization: Api-Token $DT_API_TOKEN" -H "Content-Type: text/plain; charset=utf-8" --data-binary @"$TMP_PAYLOAD" 2>/dev/null

# Remove Temp file
rm -rf "$TMP_PAYLOAD"

exit 0
