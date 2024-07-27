#!/bin/bash

# Function to install Homebrew (macOS only)
install_homebrew() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew >/dev/null 2>&1; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      echo "Homebrew is already installed"
    fi
  fi
}

# Function to install zsh
install_zsh() {
  if command -v zsh >/dev/null 2>&1; then
    echo "zsh is already installed"
  else
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Installing zsh on macOS..."
      brew install zsh
    elif [[ -f /etc/debian_version ]]; then
      echo "Installing zsh on Debian-based Linux..."
      sudo apt update
      sudo apt install -y zsh
    else
      echo "Unsupported OS. Please install zsh manually."
      exit 1
    fi
  fi
}

# Function to install Oh-My-Zsh
install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "Oh-My-Zsh is already installed"
  fi
}

# Function to install Python 3.8
install_python() {
  if ! command -v python3.8 >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Installing Python 3.8 on macOS..."
      brew install python@3.8
    elif [[ -f /etc/debian_version ]]; then
      echo "Installing Python 3.8 on Debian-based Linux..."
      sudo apt update
      sudo apt install -y python3.8
    fi
  else
    echo "Python 3.8 is already installed"
  fi
}

# Function to install OpenJDK
install_openjdk() {
  if ! command -v java >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Installing OpenJDK on macOS..."
      brew install openjdk
    elif [[ -f /etc/debian_version ]]; then
      echo "Installing OpenJDK on Debian-based Linux..."
      sudo apt update
      sudo apt install -y openjdk-11-jdk
    fi
  else
    echo "OpenJDK is already installed"
  fi
}

# Function to install chruby
install_chruby() {
  if ! command -v chruby >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "Installing chruby on macOS..."
      brew install chruby
    elif [[ -f /etc/debian_version ]]; then
      echo "Installing chruby on Debian-based Linux..."
      sudo apt update
      sudo apt install -y chruby
    fi
  else
    echo "chruby is already installed"
  fi
}

# Function to install NVM
install_nvm() {
  if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  else
    echo "NVM is already installed"
  fi
}

# Function to install Bun
install_bun() {
  if [ ! -d "$HOME/.bun" ]; then
    echo "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
  else
    echo "Bun is already installed"
  fi
}

# Function to install PNPM
install_pnpm() {
  if ! command -v pnpm >/dev/null 2>&1; then
    echo "Installing PNPM..."
    curl -fsSL https://get.pnpm.io/install.sh | sh -
  else
    echo "PNPM is already installed"
  fi
}

# Function to install Google Cloud SDK
install_gcloud() {
  if [ ! -d "$HOME/Downloads/google-cloud-sdk" ]; then
    echo "Installing Google Cloud SDK..."
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-367.0.0-darwin-x86_64.tar.gz
    tar -xvf google-cloud-sdk-367.0.0-darwin-x86_64.tar.gz -C $HOME/Downloads
    $HOME/Downloads/google-cloud-sdk/install.sh
  else
    echo "Google Cloud SDK is already installed"
  fi
}

# Function to install Spaceship prompt
install_spaceship() {
  if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    echo "Installing Spaceship prompt..."
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  else
    echo "Spaceship prompt is already installed"
  fi
}

install_homebrew
install_zsh
install_oh_my_zsh
install_python
install_openjdk
install_chruby
install_nvm
install_bun
install_pnpm
install_gcloud
install_spaceship

echo "Setup complete. Please restart your terminal."
