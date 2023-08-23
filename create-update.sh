#!/bin/bash

set -o errexit
set -o pipefail

# Number of files to be uploaded to Alfresco
FILES_COUNT=1000
# Batch size to process uploading and updating requests
BATCH_SIZE=250

# Create local files
rm -rf files && mkdir -p files

for i in $(eval echo "{0001..$FILES_COUNT}")
do
  echo "some text" > "files/file_${i}.txt" &
done

# Create folder in Alfresco Repository Shared zone
FOLDER_ID=$(./alfresco node create -n folder -i -shared- -t cm:folder -o id)

# Upload local files to Repository
start=$(date +%s)

(
for i in $(eval echo "{0001..$FILES_COUNT}")
do
  ((n=n%BATCH_SIZE)); ((n++==0)) && wait
  ./alfresco node create -n file_${i}.txt -i $FOLDER_ID -t cm:content -f $PWD/files/file_${i}.txt -o id >> /dev/null &
done
)

wait

end=$(date +%s)
echo "Node create: $(($end-$start)) seconds"

# Get document Ids from Repository
IDS=$(./alfresco node list -i $FOLDER_ID --maxItems $FILES_COUNT -o id)

# Update properties for files in Repository
start=$(date +%s)

(
for nodeId in $(echo $IDS | sed "s/,/ /g")
do
  ./alfresco node update -i $nodeId \
  -p cm:title=$nodeId \
  -p cm:description=$nodeId \
  -p cm:author=$nodeId \
  -o id >> /dev/null &  
done
)

wait

end=$(date +%s)
echo "Node update: $(($end-$start)) seconds"