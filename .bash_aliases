alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .....='cd ../../../../..'
alias cd..='cd ..'
alias c='clear'
emacshax () { emacsclient -n "$1" & }
alias e='emacsclient -t -nw'

# Ruby on Rails specific
alias rake_migrate='rake db:migrate & rake db:test:prepare'
alias parallel='rake db:migrate; rake db:test:prepare; rake paralell:prepare; rake paralell:spec'

# Promote project
alias pullmodels='git subtree pull -P dependencies/promote-models models master'
alias pulli18n='git subtree pull -P dependencies/promote-i18n i18n master'
alias pullbuilder='git subtree pull -P dependencies/promote-builder builder master'
alias testing='rake db:drop db:create db:migrate db:test:prepare && rake i18n:import_translations db:seed; ls dependencies/promote-*/spec/dummy/db/schema.rb | xargs -n 1 cp -v db/schema.rb; cd dependencies/promote-i18n/ && rvm gemset use promote-i18n && bundle && rake app:spec; cd ../promote-models/ && rvm gemset use promote-models && bundle && rake app:spec; cd ../promote-builder && rvm gemset use promote-builder && bundle && rake app:spec app:jasmine:headless; cd ../.. && rvm gemset use promote-distributor && bundle && rake konacha:run spec'
