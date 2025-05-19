#!/bin/bash

# Function to switch prompt theme
switch_prompt() {
  local theme=$1
  local style=$2
  
  # Update chezmoi data
  if [[ "$theme" == "powerlevel10k" ]]; then
    # Update both prompt theme and p10k style
    chezmoi data prompt_theme="$theme" p10k_style="$style"
  else
    # Update only prompt theme
    chezmoi data prompt_theme="$theme"
  fi
  
  # Apply changes
  chezmoi apply
  
  # Reload shell
  source ~/.zshrc
}

# Usage
case "$1" in
  "p10k")
    if [[ "$2" == "minimal" || "$2" == "neon" ]]; then
      switch_prompt "powerlevel10k" "$2"
    else
      echo "Usage: $0 p10k {minimal|neon}"
      exit 1
    fi
    ;;
  "spaceship")
    switch_prompt "spaceship"
    ;;
  *)
    echo "Usage:"
    echo "  $0 p10k {minimal|neon}  # Switch to Powerlevel10k with specified style"
    echo "  $0 spaceship            # Switch to Spaceship prompt"
    exit 1
    ;;
esac 