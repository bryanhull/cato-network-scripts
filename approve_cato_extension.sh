#!/bin/bash

# Define the system extension identifier and team identifier
EXTENSION_ID="com.catonetworks.mac.CatoClient.CatoClientSysExtension"
TEAM_ID="CKGSB8CH43"

# Log file location
LOG_FILE="/tmp/cato_extension_approval.log"

# Function to log messages
log_message() {
    local LOG_LEVEL=$1
    local MESSAGE=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$LOG_LEVEL] $MESSAGE" | tee -a "$LOG_FILE"
}

# Initialize log file with begin logging message
echo "$(date +'%Y-%m-%d %H:%M:%S') - Begin Logging" > "$LOG_FILE"

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    log_message "ERROR" "This script must be run as root."
    exit 1
fi

# Check if the system extension is already approved
APPROVED=$(systemextensionsctl list | grep -i "$EXTENSION_ID" | grep -i "activated enabled")

if [[ -z "$APPROVED" ]]; then
    log_message "INFO" "System extension not approved. Approving now..."
    
    # Approve the system extension with the correct Team Identifier
    systemextensionsctl approve "$EXTENSION_ID" "$TEAM_ID"
    
    # Check if the approval was successful
    APPROVED=$(systemextensionsctl list | grep -i "$EXTENSION_ID" | grep -i "activated enabled")
    
    if [[ -n "$APPROVED" ]]; then
        log_message "INFO" "System extension approved successfully."
    else
        log_message "ERROR" "Failed to approve the system extension."
        log_message "DEBUG" "Check if the extension ID and team ID are correct."
        log_message "DEBUG" "Extension ID: $EXTENSION_ID"
        log_message "DEBUG" "Team ID: $TEAM_ID"
        exit 1
    fi
else
    log_message "INFO" "System extension is already approved."
fi

log_message "INFO" "Script execution completed."
exit 0
