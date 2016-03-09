#!/bin/sh
# Export Files in Local Data Hub Demo To Local File System
# 
~/lib/mlcp/mlcp-8.0-4/bin/mlcp.sh EXPORT \
-host localhost -port 8030 \
-username admin -password admin \
-output_file_path /tmp/data-hub-demo
