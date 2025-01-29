#!/bin/bash

CERT_URL="https://clientdownload.catonetworks.com/public/certificates/CatoNetworksTrustedRootCA.cer"
CERT_PATH="/tmp/CatoNetworksTrustedRootCA.cer"
LOG_FILE="/tmp/install_cato_cert.log"

# Function to display error messages and exit
die() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >&2
  exit 1
}

# Redirect output to log file with date and time
exec > >(while read line; do echo "$(date +'%Y-%m-%d %H:%M:%S') - $line"; done | tee -a "$LOG_FILE") 2>&1

echo "$(date +'%Y-%m-%d %H:%M:%S') - Begin Logging"

# Check for required commands
command -v curl >/dev/null 2>&1 || die "Error: curl is not installed or not in PATH."
command -v security >/dev/null 2>&1 || die "Error: security command is not available."

# Download the certificate
echo "Downloading certificate..."
if ! curl -L -o "$CERT_PATH" "$CERT_URL"; then
  die "Error: Failed to download the certificate from $CERT_URL."
fi

# Verify the certificate file
if [[ ! -s "$CERT_PATH" ]]; then
  die "Error: Downloaded certificate file is empty or invalid."
fi

# Install the certificate
echo "Installing certificate..."
if ! sudo security import "$CERT_PATH" -k /Library/Keychains/System.keychain -A; then
  die "Error: Failed to import the certificate to the System keychain."
fi

# Set the certificate as trusted
echo "Setting certificate trust..."
if ! sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERT_PATH"; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Warning: Failed to explicitly set certificate trust. Proceeding."
fi

# Cleanup
rm -f "$CERT_PATH"

echo "Certificate successfully installed and trusted."
