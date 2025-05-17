# ~/.p10k.zsh

# -- General config ---------------------------------------------------------
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# -- Prompt style ----------------------------------------------------------
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir              # current directory
  vcs              # git status
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status           # exit code of last command
  command_execution_time
  time             # current time
)

# -- Styling ---------------------------------------------------------------
typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❯ "

typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=""
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=""
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=""
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=""
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# -- Dir Segment -----------------------------------------------------------
typeset -g POWERLEVEL9K_DIR_FOREGROUND=250
typeset -g POWERLEVEL9K_DIR_BACKGROUND=NONE
typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

# -- VCS (git) Segment -----------------------------------------------------
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=70
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=241
typeset -g POWERLEVEL9K_VCS_BACKGROUND=NONE
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '

# -- Status Segment --------------------------------------------------------
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=70
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=160
typeset -g POWERLEVEL9K_STATUS_BACKGROUND=NONE

# -- Command Time ----------------------------------------------------------
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=240
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=NONE
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3

# -- Time Segment ----------------------------------------------------------
typeset -g POWERLEVEL9K_TIME_FOREGROUND=244
typeset -g POWERLEVEL9K_TIME_BACKGROUND=NONE
typeset -g POWERLEVEL9K_TIME_FORMAT='%H:%M'

# -- Icons ---------------------------------------------------------------
typeset -g POWERLEVEL9K_MODE=nerdfont-complete
