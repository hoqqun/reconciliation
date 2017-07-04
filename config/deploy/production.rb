server '192.168.1.6', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/hoqqun/workspace/id_rsa'