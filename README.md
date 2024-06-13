# KeyKeeper
KeyKeeper is a command-line password manager with AES-256 encryption. Safely store and retrieve passwords by labels. Easy setup, robust security.

## Features

- **Add Passwords:** Securely store passwords with a label.
- **Retrieve Passwords:** Retrieve passwords by their label.
- **Display Labels:** View all stored labels without revealing passwords.
- **Encryption:** Uses AES-256 encryption for securing passwords.

## Prerequisites

- **OpenSSL:** Ensure you have OpenSSL installed on your system. You can install it using the following commands:

  - On Debian-based systems (Ubuntu, etc.):
    ```bash
    sudo apt-get install openssl
    ```

  - On Red Hat-based systems (Fedora, CentOS, etc.):
    ```bash
    sudo yum install openssl
    ```

  - On macOS:
    ```bash
    brew install openssl
    ```

## Installation

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/yourusername/password-manager-tool.git
    ```

2. **Navigate to the Directory:**

    ```bash
    cd password-manager-tool
    ```

3. **Make the Script Executable:**

    ```bash
    chmod +x password_manager.sh
    ```

## Usage

### Running the Script

To start the Password Manager Tool, run the following command:

```bash
./password_manager.sh
