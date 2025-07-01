function git-cred-store --wraps='git config --global credential.helper store' --description 'alias git-cred-store=git config --global credential.helper store'
  git config --global credential.helper store $argv
        
end
