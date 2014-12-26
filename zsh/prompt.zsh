# function git_prompt_info {
#   local ref=$(=git symbolic-ref HEAD 2> /dev/null)
#   local gitst="$(=git status 2> /dev/null)"
#   local pairname=${${${GIT_AUTHOR_EMAIL#pair+}%@github.com}//+/\/}
#   if [[ ${pairname} == 'ch' || ${pairname} == '' ]]; then
#     pairname=''
#   else
#     pairname=" ($pairname)"
#   fi

#   if [[ -f .git/MERGE_HEAD ]]; then
#     if [[ ${gitst} =~ "unmerged" ]]; then
#       gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
#     else
#       gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
#     fi
#   elif [[ ${gitst} =~ "Changes to be committed" ]]; then
#     gitstatus=" %{$fg[blue]%}!%{$reset_color%}"
#   elif [[ ${gitst} =~ "use \"git add" ]]; then
#     gitstatus=" %{$fg[red]%}!%{$reset_color%}"
#   elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
#     gitstatus=" %{$fg[yellow]%}*%{$reset_color%}"
#   else
#     gitstatus=''
#   fi

#   if [[ -n $ref ]]; then
#     echo "%{$fg_bold[green]%}/${ref#refs/heads/}%{$reset_color%}$gitstatus$pairname"
#   fi
# }

# PROMPT='%~%<< $(git_prompt_info)${PR_BOLD_WHITE}>%{${reset_color}%} '


   
# Simple zsh prompt.
#
# dotfiles ❯ (default)
# dotfiles master ❯ (in git repository)
# root@serv dotfiles master ❯ (with SSH)
#
# * is prepended to git branch name if repo is dirty.
# ❯ is green or red depending on previous command exit status.


vcs_info=''

function prompt_paulmillr_precmd {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
}

function list-files {
  echo `script -q /dev/null ls -G . | tr -d '\r' | cat`
}

function get-vcs-info {
  vcs_info=''
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local ref=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
  if [[ -z "$ref" ]]; then
    vcs_info=''
  else
    st=`git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo '*'`
    vcs_info=" %F{blue}%F{magenta}${ref}${st}%f"
  fi
}

function prompt_ravisuhag_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd get-vcs-info
  add-zsh-hook chpwd list-files
  add-zsh-hook chpwd get-vcs-info

  # zstyle ':omz:module:editor' completing '%B%F{red}...%f%b'

  PROMPT='%F{yellow}%T %F{magenta}${SSH_TTY:+%n@%m }%F{cyan}%1~%f${vcs_info}\
%(!.%B%F{red}#%f%b.%B %(?.%F{green}.%F{red})❯%f%b) '
  RPROMPT=''
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_ravisuhag_setup "$@"