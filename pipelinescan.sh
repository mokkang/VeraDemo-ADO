#!/bin/bash

echo "Usage:~#./pipelinescan.sh <InputFilePath> <vid> <vkey> "
echo "Begin Static Pipeline Scan" 
echo "######################################################################################################"

export '-f==$1' 
export '-vid==$VID'
export '-vkey==$VKEY'


java -jar /Users/jmok/pipeline-scan.jar "-f=$1" "-vid=$VID" "-vkey=$VKEY" 
