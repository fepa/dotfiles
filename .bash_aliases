alias spotify='wine "/home/fepa/.wine/drive_c/Program Files/Spotify/spotify.exe"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .....='cd ../../../../..'
alias cd..='cd ..'
alias c='clear'
emacshax () { emacsclient -n "$1" & }
alias e='emacshax'

# Ruby on Rails specific
alias rake_migrate='rake db:migrate & rake db:test:prepare'
