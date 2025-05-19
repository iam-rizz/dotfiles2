 # Spaceship Prompt Configuration

# Prompt Order
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section
  node          # Node.js section
  docker        # Docker section
  line_sep      # Line break
  char          # Prompt character
)

# Prompt Character
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# Prompt Style
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true

# Time Section
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT="%D{%H:%M:%S}"
SPACESHIP_TIME_COLOR="yellow"

# User Section
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_COLOR="green"
SPACESHIP_USER_SUFFIX=""

# Directory Section
SPACESHIP_DIR_SHOW=true
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_DIR_PREFIX="in "
SPACESHIP_DIR_TRUNC=3

# Git Section
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX="on "
SPACESHIP_GIT_SUFFIX=""
SPACESHIP_GIT_SYMBOL=""
SPACESHIP_GIT_STATUS_PREFIX="["
SPACESHIP_GIT_STATUS_SUFFIX="]"

# Node Section
SPACESHIP_NODE_SHOW=true
SPACESHIP_NODE_PREFIX="via "
SPACESHIP_NODE_SUFFIX=""
SPACESHIP_NODE_SYMBOL="⬢ "

# Docker Section
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOCKER_PREFIX="on "
SPACESHIP_DOCKER_SUFFIX=""
SPACESHIP_DOCKER_SYMBOL="🐳 "