# the path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ENV_PROJECT_FOLDER_NAME="Projetos"
export GITHUB_USERNAME=""
export GITHUB_PASSWORD=""

# awesome alias :D
alias genact='~/scripts/genact-osx'
alias nrd='npm run deploy'
alias rn='react-native'
alias s='sudo'
alias ms='mysql.server'
alias fsa='forever stopall'
alias fs='forever start\ -s'
alias fp='forever stop'
alias fl='forever list'
alias ibi='ionic build ios'
alias slogin='ruby ~/s/sonic-wall-login.rb'
alias py='python'
alias zshrc='vim ~/.zshrc'
alias zshrc.apply='source ~/.zshrc'
alias hyper-config='vim ~/.hyper.js'
alias gcm='git commit -m "merge"'
alias gpom='git push origin master'
alias gs='git status | lolcat'
alias tempo='curl -4 "http://wttr.in/Sao+Leopoldo?lang=pt"'
alias go='git checkout'
alias lzd='lazydocker'

RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

red() { printf "${RED}$1${NC}\n" }
green() { printf "${GREEN}$1${NC}\n" }

# expose some port to the world
# Usage: expose <name> <port>
expose() {
  ssh -R $1:80:localhost:$2 serveo.net
}

#temp c compiler
c() {
  rm $1.out
  gcc $1 -o $1.out #compile the file
  ./$1.out #execute the output file
}

up() {
  cd `printf '../%.0s' {1..$1}`
}

# temp c++ compiler
cpp() {
	g++ -std=c++11 $1 -o $1.out  #compile the file
	./$1.out #execute the output file
	rm $1.out #remove the output file
}

# Create a github repository
create-repository() {
	# env variables check
	if [[ "$GITHUB_USERNAME" == "" && "$GITHUB_PASSWORD" == "" ]] then
		printf "\n${RED}Please, check${NC} GITHUB_USERNAME ${RED}and${NC} GITHUB_PASSWORD ${RED}variables. :(${RED}\n"
		return
	fi
	if [[ "$GITHUB_USERNAME" == "" ]] then
		printf "\n${RED}Please, check${NC} GITHUB_USERNAME ${RED}variable. :(${NC}\n"
		return
	fi
	if [[ "$GITHUB_PASSWORD" == "" ]] then
		printf "\n${RED}Please, check${NC} GITHUB_PASSWORD ${RED}variable. :(${NC}\n"
		return
	fi

	curl --silent -u "$GITHUB_USERNAME:$GITHUB_PASSWORD" https://api.github.com/user/repos -d '{"name":"'$1'"}' > ~/.temp.txt
	rm ~/.temp.txt
	printf "\n${GREEN}Repository${NC} $1 ${GREEN}created! :D${NC}\n"

	if [[ "$2" != "" ]] then
		printf "${GREEN}Clonning at${NC} $2\n\n"
		cd $2
		git clone https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/$GITHUB_USERNAME/$1.git
		printf "\n${GREEN}Done! :D\n"
	fi
}

# ZSH theme
ZSH_THEME="bullet-train"

# bullet train config {
prompt_project_dir() {
	# extract directory project name
	PROJECT_NAME=${${PWD#*/$ENV_PROJECT_FOLDER_NAME/}%%/*}
	PROJECT_CAPITALIZED=$(tr '[:lower:]' '[:upper:]' <<< ${PROJECT_NAME:0:1})${PROJECT_NAME:1}

	# print the project name if exists
	if [[ "$PROJECT_NAME" != "" ]] &&
	prompt_segment 3 white $PROJECT_CAPITALIZED
}

# prompt order
BULLETTRAIN_PROMPT_ORDER=(
	time
	project_dir
	dir
	git
)

# colors
BULLETTRAIN_GIT_BG=10
BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=white
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
# }


# plugins
plugins=(git sudo wd zsh-autosuggestions zsh-better-npm-completion fast-syntax-highlighting)

# configs
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for ing
export PATH=$PATH:$HOME/Library/Android/sdk/tools
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.fastlane/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
