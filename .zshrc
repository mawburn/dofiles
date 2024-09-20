# Determine the OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific settings
  export ZSH="$HOME/.oh-my-zsh"
  export PATH="/opt/homebrew/bin:/opt/homebrew/opt/python@3.8/bin:$HOME/projects/AliceVision/install/bin:/opt/homebrew/opt/openjdk/bin:$PATH"
  export PNPM_HOME="$HOME/Library/pnpm"
  export GOOGLE_CLOUD_SDK_PATH="$HOME/Downloads/google-cloud-sdk"
else
  # Linux specific settings
  export ZSH="$HOME/.oh-my-zsh"
  export PATH="$HOME/.local/bin:$PATH"
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export GOOGLE_CLOUD_SDK_PATH="$HOME/google-cloud-sdk"
fi

export PYTHONPATH=$PWD

# NVM Setup (Lazy Load)
export NVM_DIR="$HOME/.nvm"
load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# PNPM
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# chruby (Lazy Load)
load_chruby() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
  else
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
  fi
  chruby ruby-2.7.4
}

# Google Cloud SDK (Lazy Load)
load_gcloud() {
  [ -f "$GOOGLE_CLOUD_SDK_PATH/path.zsh.inc" ] && . "$GOOGLE_CLOUD_SDK_PATH/path.zsh.inc"
  [ -f "$GOOGLE_CLOUD_SDK_PATH/completion.zsh.inc" ] && . "$GOOGLE_CLOUD_SDK_PATH/completion.zsh.inc"
}

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# bun completions (Lazy Load)
load_bun_completions() {
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
}

ZSH_THEME="spaceship"

plugins=(
  brew
  bun
  docker
  git
  macos
  node
  npm
  nvm
  podman
  rails
  ruby
  yarn
)

source $ZSH/oh-my-zsh.sh

SPACESHIP_CHAR_SYMBOL="🥃  "
SPACESHIP_PACKAGE_SYMBOL=""
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_PACKAGE_PREFIX=""
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_COLOR="yellow"

alias runrails="bundle exec rails server"
alias gcap="gaa && gcn! && ggf"
alias poetry="$HOME/.local/bin/poetry"
alias penv="penvSetup"
alias pinst="pip install -r requirements.txt"

penvSetup() {
  python3 -m venv venv
  source venv/bin/activate
  touch requirements.txt
  if [ ! -f .gitignore ]; then
      echo -e "venv/\n__pycache__/\n*.py[cod]\n.vscode/\n.idea/\n.DS_Store\nThumbs.db" > .gitignore
  else
      echo -e "\n# Python virtual environment\nvenv/\n\n# Python cache files\n__pycache__/\n*.py[cod]\n\n# IDE-specific files\n.vscode/\n.idea/\n\n# OS-specific files\n.DS_Store\nThumbs.db" >> .gitignore
  fi
  echo "Virtual environment created, activated, requirements.txt touched, and .gitignore updated."
}

caff() {
  caffeinate -u -d -t $(( $1 * 60 * 60 ))
}

newGitRepo() {
  if [ -z "$1" ]; then
    echo "Usage: setup_git_repo <repo-name-or-full-url>"
    return 1
  fi

  local repo=$1

  if [[ "$repo" == git@github.com:* ]]; then
    local remote_url=$repo
  else
    local remote_url="git@github.com:mawburn/${repo}.git"
  fi

  git remote add origin $remote_url
  git branch -M main
  git push -u origin main
}

## Put at end
zshaddhistory() {
  load_nvm
  load_chruby
  load_gcloud
  load_bun_completions
}
