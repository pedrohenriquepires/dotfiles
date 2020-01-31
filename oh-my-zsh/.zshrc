export ENV_PROJECT_FOLDER_NAME="Projetos"
export GITHUB_USERNAME=""
export GITHUB_PASSWORD=""

# awesome alias :D
alias genact='~/scripts/genact-osx'
alias zshrc='vim ~/.zshrc'
alias zshrc.apply='source ~/.zshrc'
alias hyper-config='vim ~/.hyper.js'
alias tempo='curl -4 "http://wttr.in/Sao+Leopoldo?lang=pt"'
alias go='git checkout'
alias lzd='lazydocker'

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

red() { echo "${RED}$1${NC}\n" }
green() { echo "${GREEN}$1${NC}\n" }

# expose some port to the world
# Usage: expose <name> <port>
expose() {
  ssh -R $1:80:localhost:$2 serveo.net
}

# temp c compiler
c() {
  rm $1.out
  gcc $1 -o $1.out #compile the file
  ./$1.out #execute the output file
}

# temp c++ compiler
cpp() {
	g++ -std=c++11 $1 -o $1.out  #compile the file
	./$1.out #execute the output file
	rm $1.out #remove the output file
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
prompt_project_dir() {
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

ZSH_THEME="bullet-train"

# prompt order
BULLETTRAIN_PROMPT_ORDER=(
	time
	custom_nvm
  project_dir
	git
)

# colors
BULLETTRAIN_GIT_BG=10
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=white
BULLETTRAIN_GIT_COLORIZE_DIRTY=true

# remove nvm prefix (⬡)
BULLETTRAIN_NVM_PREFIX=""

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

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for ing
export PATH="$PATH:$HOME/Library/Android/sdk/tools"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$HOME/.fastlane/bin:$PATH"

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
