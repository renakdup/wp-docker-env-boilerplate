#!/usr/bin/env sh

# Check if the system_profiler command exists
if ! command -v system_profiler >/dev/null 2>&1 ; then
  echo "You are not using a Mac."
  exit 0
else
  echo "You are using a Mac."
fi

# Get the processor information
processor_info=$(system_profiler SPHardwareDataType | grep 'Apple M1')

# Check if the processor information contains the "Apple M1" string
if [ -z "$processor_info" ]; then
  echo "You are not using a Mac with an M1 chip (likely Intel)."
else
  echo "You are using a Mac with an M1 chip."

  # Check if the docker-compose.override.yaml file already exists
  if [ -e docker-compose.override.yaml ]; then
    echo "YAML file 'docker-compose.override.yaml' already exists. Not creating a new one."
  else
    # Create the docker-compose.override.yaml file only for M1 Macs
    cat <<EOL >docker-compose.override.yaml
services:
  mysql:
    platform: linux/amd64
EOL

    echo "YAML file 'docker-compose.override.yaml' has been created for the M1 chip."
  fi
fi
