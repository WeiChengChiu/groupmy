server '54.250.184.223', user: 'apps', roles: %w{app db web}

set :ssh_options, {
  user: "apps",
  forward_agent: true
}
