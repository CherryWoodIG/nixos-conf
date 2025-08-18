{ config, pkgs, lib, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Custom Themed Prompt
      ice_prompt() {
        local last_exit=$?
        
        # Color definitions
        local RESET='\[\033[0m\]'
        local BOLD='\[\033[1m\]'
        
        # Ice colors (darker for white background)
        local ICE_BLUE='\[\033[38;5;24m\]'       # Dark steel blue
        local FROST_BLUE='\[\033[38;5;17m\]'     # Navy blue
        local CRYSTAL='\[\033[38;5;30m\]'        # Dark cyan
        local ARCTIC_WHITE='\[\033[30m\]'        # Black (for contrast)
        local GLACIER='\[\033[38;5;25m\]'        # Dark blue
        local POLAR='\[\033[38;5;23m\]'          # Dark slate blue
        
        # Status colors (darker)
        local SUCCESS='\[\033[38;5;22m\]'        # Dark green
        local ERROR='\[\033[38;5;88m\]'          # Dark red
        
        # Build prompt components
        local user_host="''${ICE_BLUE}''${BOLD}❄ ''${CRYSTAL}\u''${ARCTIC_WHITE}@''${FROST_BLUE}\h''${RESET}"
        local current_dir="''${GLACIER}''${BOLD} \w''${RESET}"
        
        # Git branch if in git repo
        local git_branch=""
        if git rev-parse --git-dir > /dev/null 2>&1; then
            local branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
            git_branch="''${POLAR} ❅ ''${branch}''${RESET}"
        fi
        
        # Exit status indicator
        local status_symbol=""
        if [ $last_exit -eq 0 ]; then
            status_symbol="''${SUCCESS}''${BOLD} ◆''${RESET}"
        else
            status_symbol="''${ERROR}''${BOLD} ◇''${RESET}"
        fi
        
        # Combine all parts
        PS1="''${user_host}''${current_dir}''${git_branch}''${status_symbol} ''${CRYSTAL}''${BOLD}➤''${RESET} "
    }

      # Set the prompt
      PROMPT_COMMAND=ice_prompt

      # Ice-themed aliases
      alias ls='ls --color=auto'
      alias ll='ls -la --color=auto'
      alias la='ls -A --color=auto'
      alias l='ls -CF --color=auto'

      # Navigation aliases
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias ~='cd ~'
      alias -- -='cd -'

      # NixOS specific aliases
      alias rebuild='sudo nixos-rebuild switch'
      alias update='sudo nixos-rebuild switch --upgrade'
      alias garbage='sudo nix-collect-garbage -d'
      alias garbageweek='sudo nix-collect-garbage --delete-older-than 7d'
      alias usergarbage='nix-collect-garbage -d'
      alias optimise='nix-store --optimise'

      # Enhanced history
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoredups:erasedups
      shopt -s histappend

      # Environment
      export EDITOR='vim'
      export BROWSER='firefox'
      export TERM='xterm-256color'
    '';
  };
}