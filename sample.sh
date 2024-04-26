#!/bin/bash

T_FILE_NAME='sample.txt'
T_LINE_MAX=7
T_LINE_COUNTER=0
while IFS= read -r T_1LINE || [ -n "$T_LINE" ]  &&  [ "$T_LINE_COUNTER" -lt "$T_LINE_MAX" ]
do
T_LINE_COUNTER=$((  T_LINE_COUNTER +  1 )) 
echo "LINE_NO=${T_LINE_COUNTER}= LINE_CONTENT=${T_1LINE}="
done < "${T_FILE_NAME}"
