load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'

# ========================
#     For FCGI Apps
# ========================
# NB: running the following :start task will delete your main public_html directory.
# So don't use these commands if you have existing sites in here.

namespace :deploy do

  task :start, :roles => :app do
    run "rm -rf /home/#{user}/mma4/public/blog;ln -s #{current_path}/public /home/#{user}/mma4/public/blog"
  end

  task :restart, :roles => :app do
    run "#{current_path}/script/process/reaper --dispatcher=dispatch.fcgi"
  end

  desc "Restarting after deployment"
  task :after_deploy, :roles => [:app, :db, :web] do
   run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
   run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
  end


end

# ========================
#    For Mongrel Apps
# ========================

# namespace :deploy do
# 
#   task :start, :roles => :app do
#     run "rm -rf /home/#{user}/public_html;ln -s #{current_path}/public /home/#{user}/public_html"
#     run "cd #{current_path} && mongrel_rails start -e production -p #{mongrel_port} -d"
#   end
# 
#   task :restart, :roles => :app do
#     run "cd #{current_path} && mongrel_rails restart"
#   end
# 
# end

# ========================
# For Mongrel Cluster Apps
# ========================

# namespace :deploy do
# 
#   task :start, :roles => :app do
#     run "cd #{current_path} && mongrel_rails cluster::configure -e production -p #{mongrel_port}0 -N #{mongrel_nodes} -c #{current_path} --user #{user} --group #{user}"
#     run "cd #{current_path} && mongrel_rails cluster::start"
#     run "rm -rf /home/#{user}/public_html;ln -s #{current_path}/public /home/#{user}/public_html"
#     run "mkdir -p #{deploy_to}/shared/config"
#     run "mv #{current_path}/config/mongrel_cluster.yml #{deploy_to}/shared/config/mongrel_cluster.yml"
#     run "ln -s #{deploy_to}/shared/config/mongrel_cluster.yml #{current_path}/config/mongrel_cluster.yml"
#   end
# 
#   task :restart, :roles => :app do
#     run "ln -s #{deploy_to}/shared/config/mongrel_cluster.yml #{current_path}/config/mongrel_cluster.yml"
#     run "cd #{current_path} && mongrel_rails cluster::restart"
#   end
# 
# end

# ========================
# For mod_rails apps
# ========================
# This assumes that your database.yml file is NOT in subversion,
# but instead is in your deploy_to/shared directory. Database.yml
# files should *never* go into subversion for security reasons.

# namespace :deploy do
#   task :start, :roles => :app do
#     run "touch #{deploy_to}/current/tmp/restart.txt"
#   end
#   
#   task :restart, :roles => :app do
#     run "touch #{deploy_to}/current/tmp/restart.txt"
#   end
# 
#   task :after_symlink, :roles => :app do
#     run "rm -f ~/public_html;ln -s #{deploy_to}/current/public ~/public_html"
#     run "ln -s #{deploy_to}/shared/database.yml #{deploy_to}/current/config/database.yml"
#   end
# end