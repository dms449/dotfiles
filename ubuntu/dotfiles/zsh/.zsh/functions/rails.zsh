# vim:foldmethod=indent:foldlevel=0
docker_exec () { DOCKER_CLI_HINTS=false docker exec -it baldwin-web-web-1 /bin/bash -c "$*" }

bbun () { docker_exec "bun $@" }

be () { docker_exec "bundle exec $@" }
bu () { docker_exec "bundle update $@" }
bi () { docker_exec "bundle install $@" }

ber () { docker_exec "bundle exec rails $@" }
bes () { docker_exec "RAILS_ENV=test bundle exec rspec $@" }
bep () { docker_exec "bundle exec rake parallel:spec[$RSPEC_CORES] RAILS_ENV=test" }
bec () { docker_exec "bundle exec rubocop --except Metrics,Layout/LineLength $@" }
bra () { docker_exec "bundle exec brakeman --no-pager --faster --skip-files bundle/ -q $@" }

mi () { docker_exec "bundle exec rake db:migrate RAILS_ENV=development" }
rb () { docker_exec "bundle exec rake db:rollback STEP=1 RAILS_ENV=development" }
mit () { docker_exec "bundle exec rake db:migrate RAILS_ENV=test" }
pmit () { docker_exec "bundle exec rake parallel:migrate[$RSPEC_CORES]" }

rl () { docker_exec "bundle exec rails routes"  }

edit_credentials () { docker_exec "EDITOR=nvim bundle exec rails credentials:edit --environment=$@" }

clean_devdb() { docker_exec "bundle exec rake db:drop db:setup RAILS_ENV=development" }
clean_testdb() { docker_exec "bundle exec rake db:drop db:create db:schema:load RAILS_ENV=test" }
pclean_testdb() { docker_exec "bundle exec rake parallel:drop[$RSPEC_CORES] parallel:setup[$RSPEC_CORES] RAILS_ENV=test" }

dwork() { docker_exec "bundle exec rake resque:work QUEUE=*" }
dschedule() { docker_exec "bundle exec rake resque:scheduler" }
becac () {
  changed_files=$(git diff --name-only $(base_branch) HEAD | grep '\.rb$')

  if [ -z "$changed_files" ]; then
    echo "No Ruby files changed"
    return 0
  fi

  docker_exec "bundle exec rubocop -a --except Metrics,Layout/LineLength $changed_files"
}
prod () {
    eval $(ssh-agent); ssh-add ~/.ssh/baldwinsafety.pem
    ssh -A ec2-user@3.221.182.48
}

qa () {
    eval $(ssh-agent); ssh-add ~/.ssh/baldwindemo.pem
    ssh -A ec2-user@18.233.223.197
}
