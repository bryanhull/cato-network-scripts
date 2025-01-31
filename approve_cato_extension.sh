#!/bin/bash

# Define the system extension identifier and team identifier
EXTENSION_ID="com.catonetworks.mac.CatoClient.CatoClientSysExtension"
TEAM_ID="CKGSB8CH43"

# Log file location
LOG_FILE="/tmp/cato_extension_approval.log"

# Function to display error messages and exit
die() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >&2
  exit 1
}

# Redirect output to log file with date and time
exec > >(while read line; do echo "$(date +'%Y-%m-%d %H:%M:%S') - $line"; done | tee -a "$LOG_FILE") 2>&1

# Initialize log file with begin logging message
echo "Begin Logging"

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    die "This script must be run as root."
fi

# Check if the system extension is already approved
APPROVED=$(systemextensionsctl list | grep -i "$EXTENSION_ID" | grep -i "activated enabled")

if [[ -z "$APPROVED" ]]; then
    echo "System extension not approved. Approving now..."
    
    # Approve the system extension with the correct Team Identifier
    systemextensionsctl approve "$EXTENSION_ID" "$TEAM_ID"
    
    # Check if the approval was successful
    APPROVED=$(systemextensionsctl list | grep -i "$EXTENSION_ID" | grep -i "activated enabled")
    
    if [[ -n "$APPROVED" ]]; then
        echo "System extension approved successfully."
    else
        die "Failed to approve the system extension. Check if the extension ID and team ID are correct. Extension ID: $EXTENSION_ID, Team ID: $TEAM_ID"
    fi
else
    echo "System extension is already approved."
fi

echo "Script execution completed."
exit 0
