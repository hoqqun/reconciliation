server '192.168.1.30', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/hoqqun/.ssh/id_rsa'