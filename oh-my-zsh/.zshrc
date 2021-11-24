export ENV_PROJECT_FOLDER_NAME="Projetos"
export GITHUB_USERNAME=""
export GITHUB_PASSWORD=""

# awesome alias :D
alias vpn-connect='sudo openvpn --config ~/dev/vpn/pfSense-saipos-TCP4-4445-pedro.pires-config.ovpn --daemon --auth-user-pass ~/dev/vpn/credentials.txt'
alias vpn-disconnect='sudo killall -SIGINT openvpn'
alias zshrc='code ~/.zshrc'
alias zshrc.apply='source ~/.zshrc'
alias hyper-config='vim ~/.hyper.js'
alias go='git checkout'
alias lzd='lazydocker'
alias open='wsl-open'
alias ngrok='~/dev/ngrok'
alias ngrok1='ngrok authtoken 1XIY5DFxosWr7rVBw9SFXxlOTjX_2EbAxUAf1KFrRQFCPMFpy'
alias ngrok2='ngrok authtoken 1qvqWMEPtMoa0Z7KjQlHVZfIX4k_6XyBfKkSRTrGZYmxujcmT'
alias code='silent_code'

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

red() { echo "${RED}$1${NC}\n" }
green() { echo "${GREEN}$1${NC}\n" }

expose() {
  npx localtunnel --port $1 --local-host localhost
}

silent_code() {
  nohup code $1 > /tmp/nohup.out
}

up() {
  cd `printf '../%.0s' {1..$1}`
}

# Create a github repository
create-repository() {
  # env variables check
  if [[ "$GITHUB_USERNAME" == "" && "$GITHUB_PASSWORD" == "" ]] then
    echo "\n${RED}Please, check${NC} GITHUB_USERNAME ${RED}and${NC} GITHUB_PASSWORD ${RED}variables. :(${RED}\n"
    return
  fi
  if [[ "$GITHUB_USERNAME" == "" ]] then
    echo "\n${RED}Please, check${NC} GITHUB_USERNAME ${RED}variable. :(${NC}\n"
    return
  fi
  if [[ "$GITHUB_PASSWORD" == "" ]] then
    echo "\n${RED}Please, check${NC} GITHUB_PASSWORD ${RED}variable. :(${NC}\n"
    return
  fi

  curl --silent -u "$GITHUB_USERNAME:$GITHUB_PASSWORD" https://api.github.com/user/repos -d '{"name":"'$1'"}' > ~/.temp.txt
  rm ~/.temp.txt
  echo "\n${GREEN}Repository${NC} $1 ${GREEN}created! :D${NC}\n"

  if [[ "$2" != "" ]] then
    echo "${GREEN}Clonning at${NC} $2\n\n"
    cd $2
    git clone https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/$GITHUB_USERNAME/$1.git
    echo "\n${GREEN}Done! :D\n"
  fi
}

# add the project name before the dir path
prompt_custom_dir() {
  # extract the company name and the project path
  local COMPANY_NAME=${${PWD#*/$ENV_PROJECT_FOLDER_NAME/}%%/*}
  local PROJECT_PATH=${${PWD#*/$COMPANY_NAME}%%/}

  # captalize the first letter of company
  local COMPANY_CAPITALIZED=$(tr '[:lower:]' '[:upper:]' <<< ${COMPANY_NAME:0:1})${COMPANY_NAME:1}

  if [[ "$COMPANY_NAME" != "" ]] then
    prompt_segment 3 white $COMPANY_CAPITALIZED

    if [[ "$PROJECT_PATH" != "" ]] then
      prompt_segment 4 white ${PROJECT_PATH:1}
    fi
  else
    prompt_dir
  fi
}

# show node version if found a .nvmrc file
prompt_custom_nvm() {
  [[ -a .nvmrc ]] || return

  prompt_nvm
}

# Pure Theme
  fpath+=$HOME/.zsh/pure
  autoload -U promptinit; promptinit
  prompt pure

  zstyle :prompt:pure:path color "#F0D45E"
  zstyle :prompt:pure:git:branch color green

# plugins
plugins=(
  git 
  sudo 
  wd 
  zsh-autosuggestions 
  zsh-better-npm-completion 
  fast-syntax-highlighting
)

# configs
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="/snap/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for ing
export PATH="$PATH:/mnt/c/Users/pdrhe/AppData/Local/Programs/Microsoft VS Code/bin" # Add code command
export PATH="$PATH:$HOME/.nvm/versions/node/v16.13.0/bin/"

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# call `nvm use` automatically in a directory with a .nvmrc file {
autoload -U add-zsh-hook
local NODE_LTS="$(nvm version default)"

load-nvmrc() {
  local node_version="$(nvm version)"

  [[ -a .nvmrc || "$node_version" != "$NODE_LTS" ]] || return

  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
# }

# the path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
