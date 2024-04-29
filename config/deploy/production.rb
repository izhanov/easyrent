server "185.22.65.71", user: "deployer", roles: %w{app db web worker}, primary: true
set :rails_env, :production

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password),
  port: 6776
}

set :systemctl_user, :system
set :sidekiq_roles, :app
set :sidekiq_env, :production
