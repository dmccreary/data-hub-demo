#!/bin/sh
# https://docs.marklogic.com/guide/ingestion/content-pump#id_68375
# this one is optional -database west-academic
~/lib/mlcp/mlcp-8.0-4/bin/mlcp.sh IMPORT \
-host localhost -port 8040 \
-username admin -password admin \
# this is where to ge the files from
-input_file_path app \
# replace the long base folder path name URI with null
-output_uri_replace "/Users/dmccrear/Documents/workspace/data-hub-demo/app,''"
