#!/usr/bin/env bash

#!/bin/bash

#!/bin/bash

# Define the array with site types
site_types=(
  "simple site"
  "multisite subdirectories"
  "multisite subdomain"
)

# Display available site types to choose from
echo "Choose which type of site you want to use, write only number:"
for i in "${!site_types[@]}"; do
  echo "$(($i + 1)). ${site_types[$i]}"
done

# Read the user's input
read -p "Enter the number: " choice

# Validate input - ensure it's a number within the array's bounds
if [[ "$choice" =~ ^[1-3]$ ]]; then
  if [ "$choice" == "1" ]; then
    echo "1"
  elif [ "$choice" == "2" ]; then
    echo "2"
  else
    echo "3"
  fi
else
# Generate a string with valid input range
  valid_range=$(seq -s ', ' 1 "${#site_types[@]}")

  # Remove the last ', ' from valid_range
  valid_range="${valid_range%, }"

  echo "Invalid input. Please enter one of the following numbers: ${valid_range}."
fi
