#!/bin/bash

# Define the Java version to install
JAVA_VERSION="11"  # Update this to the desired Java version (e.g., 8, 11, 15, etc.)

# Define the Kotlin version to install
KOTLIN_VERSION="1.5.21"  # Update this to the latest Kotlin version available

# Define the installation directories
JAVA_INSTALL_DIR="/usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64"
KOTLIN_INSTALL_DIR="/opt/kotlin"

# Install Java Development Kit (JDK)
sudo apt update
sudo apt install -y openjdk-$JAVA_VERSION-jdk

# Download Kotlin compiler and tools
wget -O kotlin-compiler.zip "https://github.com/JetBrains/kotlin/releases/download/v$KOTLIN_VERSION/kotlin-compiler-$KOTLIN_VERSION.zip"

# Create the installation directory if it doesn't exist
sudo mkdir -p "$KOTLIN_INSTALL_DIR"

# Extract Kotlin compiler and tools
sudo unzip -q kotlin-compiler.zip -d "$KOTLIN_INSTALL_DIR"

# Set environment variables for Kotlin
echo "export PATH=\$PATH:$KOTLIN_INSTALL_DIR/kotlinc/bin" >> ~/.bashrc
echo "export KOTLIN_HOME=$KOTLIN_INSTALL_DIR/kotlinc" >> ~/.bashrc
source ~/.bashrc

# Clean up downloaded zip file
rm kotlin-compiler.zip

echo "Java JDK $JAVA_VERSION and Kotlin v$KOTLIN_VERSION have been installed successfully!"
