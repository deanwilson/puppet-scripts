_puppetca()
{

  local cur opts

  cur=${COMP_WORDS[COMP_CWORD]}
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="--clean --list --sign --help"

  if [[ ${cur} == -* ]] ; then
    COMPREPLY=($( compgen -W  "${opts}" -- ${cur}) )
    return 0
  fi

  if [[ ${prev} == "--clean" ]] ; then
     COMPREPLY=( $( compgen -W "$( ls /var/lib/puppet/ssl/ca/signed/*.pem 2>/dev/null | xargs -I {} basename {} .pem )" -- ${cur} ) )
     return 0
  fi

  if [[ ${prev} == "--list" ]] ; then
     COMPREPLY=( $( compgen -W "--all" -- ${cur}) )
     return 0
  fi

}

complete -F _puppetca puppetca
