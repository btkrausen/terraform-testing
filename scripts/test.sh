#!/bin/bash
set -e

# This script validates Terraform modules against a specific Terraform version
# Usage: ./test.sh <module_path> <terraform_version>

# Arguments
MODULE_PATH=$1
TF_VERSION=$2

# Log to both console and file
log() {
  echo "$1"
}

log "Testing module: $MODULE_PATH with Terraform version: $TF_VERSION"

# Install and use specified Terraform version
log "Setting up Terraform version $TF_VERSION"
TF_DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"
log "Downloading from: $TF_DOWNLOAD_URL"

# Try multiple times with verification
MAX_ATTEMPTS=3
for attempt in $(seq 1 $MAX_ATTEMPTS); do
  log "Download attempt $attempt of $MAX_ATTEMPTS"
  
  # Clear any previous download
  rm -f terraform.zip
  
  # Download with curl, following redirects, showing progress
  curl -L --fail -# -o terraform.zip $TF_DOWNLOAD_URL
  
  # Verify the download
  if [ -f terraform.zip ] && unzip -t terraform.zip > /dev/null 2>&1; then
    log "Download successful and verified"
    break
  else
    log "Download failed or verification failed"
    if [ $attempt -eq $MAX_ATTEMPTS ]; then
      log "❌ ERROR: Failed to download Terraform after $MAX_ATTEMPTS attempts"
      exit 1
    fi
    # Wait before trying again
    sleep 5
  fi
done

# Now extract it
log "Extracting Terraform binary"
unzip -o terraform.zip
chmod +x terraform
export PATH=$PWD:$PATH

# Print Terraform version for logging
log "$(terraform version)"

# Create temporary working directory
TEMP_DIR=$(mktemp -d)
log "Working in temporary directory: $TEMP_DIR"

# Copy module files to temp directory
cp -r $MODULE_PATH/* $TEMP_DIR/

# Navigate to working directory
cd $TEMP_DIR

# Run tests with detailed error capturing
log "Initializing Terraform..."
if ! terraform init -no-color; then
  log "❌ ERROR: Terraform init failed"
  exit 1
fi

log "Validating Terraform configuration..."
if ! terraform validate -no-color; then
  log "❌ ERROR: Terraform validate failed"
  exit 1
fi

# Run terraform plan and capture the exit code correctly
log "Running terraform plan..."
terraform plan -no-color -detailed-exitcode > plan_output.txt 2>&1
PLAN_EXIT_CODE=$?

# Check exit code:
# 0 = Success, no changes
# 1 = Error
# 2 = Success, changes present
if [ $PLAN_EXIT_CODE -eq 0 ]; then
  log "✅ Plan successful - No changes required"
elif [ $PLAN_EXIT_CODE -eq 2 ]; then
  log "✅ Plan successful - Changes detected"
  # Override the exit code for GitHub Actions
  # This makes GitHub Actions show this as a success
  exit 0
else
  log "❌ ERROR: Terraform plan failed"
  cat plan_output.txt >> $LOG
  exit 1
fi

# Clean up
cd - > /dev/null
rm -rf $TEMP_DIR
rm terraform terraform.zip

log "✅ Test completed successfully for $MODULE_PATH with Terraform $TF_VERSION"