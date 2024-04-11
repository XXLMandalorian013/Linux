#!/bin/bash
# Removed the EDR Folder
rm -r /usr/local/share/CentraStage/AEMAgent/RMM.AdvancedThreatDetection
sleep 10
# Kills the AEMAgent process to allow the folder to be recreated.
kill $(pgrep AEMAgent)
# Sleeps so the folder can be repopulated
sleep 1200
# Removed the EDR Folder as this needs done twice to eliminate the posible issue of file older then 3-13-24's update.
rm -r /usr/local/share/CentraStage/AEMAgent/RMM.AdvancedThreatDetection
sleep 10
# Kills the AEMAgent process to allow the folder to be recreated.
kill $(pgrep AEMAgent)
sleep 1200
# Starts the EDR service.
systemctl start HUNTAgent
# Gets the EDR services status.
systemctl status HUNTAgent