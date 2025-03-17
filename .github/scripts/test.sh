#!/bin/bash
set -e

# This script validates Terraform modules against a specific Terraform version
# Usage: ./test.sh <module_path> <terraform_version>

# Arguments
MODULE_PATH=$1
TF_VERSION=$2

# Set up logging
LOG_FILE="test-output.log"
echo "Terraform Module Compatibility Test" > $LOG_FILE
echo "=================================" >> $LOG_FILE
echo "Module: $MODULE_PATH" >> $LOG_FILE
echo "Terraform Version: $TF_VERSION" >> $LOG_FILE
echo "Date: $(date)" >> $LOG_FILE
echo "=================================" >> $LOG_FILE

# Log to both console and file
log() {
  echo "$1"
  echo "$1" >> $LOG_FILE
}

log "Testing module: $MODULE_PATH with Terraform version: $TF_VERSION"

# Install and use specified Terraform version
log "Setting up Terraform version $TF_VERSION"
curl -s https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip 2>> $LOG_FILE
unzip -o terraform.zip >> $LOG_FILE 2>&1
chmod +x terraform
export PATH=$PWD:$PATH

# Print Terraform version for logging
log "$(terraform version)"

# Create temporary working directory
TEMP_DIR=$(mktemp -d)
log "Working in temporary directory: $TEMP_DIR"

# Copy module files to temp directory
cp -r $MODULE_PATH/* $TEMP_DIR/ 2>> $LOG_FILE

# Navigate to working directory
cd $TEMP_DIR

# Run tests with detailed error capturing
log "Initializing Terraform..."
if ! terraform init -no-color >> $LOG_FILE 2>&1; then
  log "❌ ERROR: Terraform init failed"
  cat $LOG_FILE
  exit 1
fi

log "Validating Terraform configuration..."
if ! terraform validate -no-color >> $LOG_FILE 2>&1; then
  log "❌ ERROR: Terraform validate failed"
  cat $LOG_FILE
  exit 1
fi

log "Running terraform plan..."
if ! terraform plan -no-color -detailed-exitcode >> $LOG_FILE 2>&1; then
  # Exit code 2 means changes detected, which is fine for validation
  if [ $? -ne 2 ]; then
    log "❌ ERROR: Terraform plan failed"
    cat $LOG_FILE
    exit 1
  fi
fi

# Clean up
cd - > /dev/null
rm -rf $TEMP_DIR
rm terraform terraform.zip

log "✅ Test completed successfully for $MODULE_PATH with Terraform $TF_VERSION"
mv $LOG_FILE $(dirname $0)/$LOG_FILE