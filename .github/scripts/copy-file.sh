#!/usr/bin/env bash

# File to copy from Notehub
COPYING_FILE=./shivani/api/gitfile.txt

# if the file exists in Notehub, copy it to Notehub-JS repo
if [ -f "$COPYING_FILE" ]; then
    echo "Copying $OPENAPI_FILE"
    cp $COPYING_FILE $DESTINATION_PATH
fi

echo "File $DESTINATION_PATH copied successfully."
