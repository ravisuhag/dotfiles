function git_prompt_info {
  local ref=$(=git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(=git status 2> /dev/null)"
  local pairname=${${${GIT_AUTHOR_EMAIL#pair+}%@github.com}//+/\/}
  if [[ ${pairname} == 'ch' || ${pairname} == '' ]]; then
    pairname=''
  else
    pairname=" ($pairname)"
  fi

  if [[ -f .git/MERGE_HEAD ]]; then

    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
    else
      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
    fi

  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" %{$fg[blue]%}✚ %{$reset_color%}"

  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" %{$fg[red]%}✭ %{$reset_color%}"

  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" %{$fg[yellow]%}⬆ %{$reset_color%}"

  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$fg_bold[green]%}/${ref#refs/heads/}%{$reset_color%}$gitstatus$pairname"
  fi
}

PROMPT='%~%<< ${PR_BOLD_WHITE}>%{${reset_color}%} '

RPROMPT='$(git_prompt_info)'



# screenshot: http://i.imgur.com/aipDQ.png

# if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
#   MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
#   local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%}"
  
#   PROMPT='%{$fg[cyan]%}%c$(git_prompt_info) %(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%}❯)%{$reset_color%} '

#   ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git%{$reset_color%}:%{$fg[red]%}"
#   ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#   ZSH_THEME_GIT_PROMPT_DIRTY=""
#   ZSH_THEME_GIT_PROMPT_CLEAN=""

#   RPROMPT='${return_status}$(git_prompt_status)%{$reset_color%}'

#   ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
#   ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
#   ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
#   ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
#   ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
#   ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
# else 
#   MODE_INDICATOR="❮❮❮"
#   local return_status="%(?::⏎)"
  
#   PROMPT='%c$(git_prompt_info) %(!.#.❯) '

#   ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
#   ZSH_THEME_GIT_PROMPT_SUFFIX=""
#   ZSH_THEME_GIT_PROMPT_DIRTY=""
#   ZSH_THEME_GIT_PROMPT_CLEAN=""

#   RPROMPT='${return_status}$(git_prompt_status)'

#   ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
#   ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
#   ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
#   ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
#   ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
#   ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
# fi
