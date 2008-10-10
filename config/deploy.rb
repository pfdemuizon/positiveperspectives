set :application, "positiveperspectives"
set :repository,  "git@github.com:pfdemuizon/positiveperspectives.git"

set :user, "pfdemuizon"
set :group, "pfdemuizon"

# use git
set :scm, :git
set :git_enable_submodules, 1

set :deploy_to, "/home/pfdemuizon/#{application}"

set :deploy_via, :remote_cache
set :keep_releases, 10
set :use_sudo, false

role :app, "positiveperspectives.graspbirdstail.com"
role :web, "positiveperspectives.graspbirdstail.com"
role :db,  "positiveperspectives.graspbirdstail.com", :primary => true

after "deploy:update_code", "deploy:symlink_shared"

namespace :deploy do
  task :symlink_shared, :roles => :app, :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    invoke_command "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
    invoke_command "ln -nfs #{shared_path}/pids #{release_path}/pids"
  end
  task :restart do
    invoke_command "touch #{release_path}/tmp/restart.txt"
  end
end
