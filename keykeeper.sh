#!/bin/bash

# File to store encrypted passwords
PASSWORD_FILE="passwords.enc"
KEY_FILE="key.bin"

# Colors for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to generate a random key if it doesn't exist
generate_key() {
  if [ ! -f "$KEY_FILE" ]; then
    openssl rand -base64 32 > "$KEY_FILE"
    echo -e "${GREEN}Encryption key generated and stored in $KEY_FILE${NC}"
  fi
}

# Function to add a password
# Function to add a password
add_password() {
  read -sp "Enter password to store: " password1
  echo
  read -sp "Re-enter password: " password2
  echo
  if [ "$password1" != "$password2" ]; then
    echo -e "${RED}Error: Passwords do not match.${NC}"
    return 1
  fi

  read -p "Enter a label for this password: " label

  encrypted_password=$(echo "$password1" | openssl enc -aes-256-cbc -a -salt -pass file:"$KEY_FILE")

  echo "$label:$encrypted_password" >> "$PASSWORD_FILE"
  echo -e "${GREEN}Password stored successfully.${NC}"
}


# Function to retrieve a password
retrieve_password() {
  read -p "Enter the label of the password to retrieve: " label

  grep "^$label:" "$PASSWORD_FILE" | while IFS= read -r line; do
    encrypted_password=$(echo "$line" | cut -d':' -f2-)
    decrypted_password=$(echo "$encrypted_password" | openssl enc -aes-256-cbc -d -a -salt -pass file:"$KEY_FILE")

    echo -e "${YELLOW}Password for $label: $decrypted_password${NC}"
  done
}

# Function to display all labels
display_labels() {
  echo -e "${BLUE}Stored labels:${NC}"
  cut -d':' -f1 "$PASSWORD_FILE" | nl
}

# Function to display the menu
show_menu() {
  echo -e "${BLUE}  _  __            _  __                         ${NC}"
  echo -e "${BLUE} | |/ /           | |/ /                         ${NC}"
  echo -e "${BLUE} | ' / ___ _   _  | ' / ___  ___ _ __   ___ _ __ ${NC}"
  echo -e "${BLUE} |  < / _ \ | | | |  < / _ \/ _ \ '_ \ / _ \ '__|${NC}"
  echo -e "${BLUE} | . \  __/ |_| | | . \  __/  __/ |_) |  __/ |   ${NC}"
  echo -e "${BLUE} |_|\_\___|\__, | |_|\_\___|\___| .__/ \___|_|   ${NC}"
  echo -e "${BLUE}            __/ |               | |              ${NC}"
  echo -e "${BLUE}           |___/                |_|              ${NC}"
  echo -e "${BLUE}---------------------------------${NC}"
  echo -e "${YELLOW}1. Add a password${NC}"
  echo -e "${YELLOW}2. Retrieve a password${NC}"
  echo -e "${YELLOW}3. Display all labels${NC}"
  echo -e "${YELLOW}4. Exit${NC}"
}

# Generate encryption key if not already present
generate_key

# Main loop
while true; do
  show_menu
  read -p "Choose an option: " option
  case $option in
    1) add_password ;;
    2) retrieve_password ;;
    3) display_labels ;;
    4) echo -e "${RED}Goodbye!${NC}"; exit ;;
    *) echo -e "${RED}Invalid option. Please try again.${NC}" ;;
  esac
done
