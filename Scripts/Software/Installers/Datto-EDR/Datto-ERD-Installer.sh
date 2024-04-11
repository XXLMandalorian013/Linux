

#!/bin/bash
outputlocation="/usr/bin/"

curl --silent https://infocyte-support.s3.us-east-2.amazonaws.com/executables/agent.linux64.exe --output /"$outputlocation"/agent.linux-amd64.891f91aefeed0d64fab1dc780f59c0378375d6f2b42b1db56d6e74e6249d56d1.exe

CD "$outputlocation"

chmod +x agent.linux-amd64.891f91aefeed0d64fab1dc780f59c0378375d6f2b42b1db56d6e74e6249d56d1.exe
#Be sure to change --url https://rmma1234567.infocyte.com to the correct site before running.
sudo ./agent.linux-amd64.891f91aefeed0d64fab1dc780f59c0378375d6f2b42b1db56d6e74e6249d56d1.exe --key 2vt3qhepxv --url https://rmma1234567.infocyte.com