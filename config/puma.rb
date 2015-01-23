#!/usr/bin/env puma

# app do |env|
#   puts env
#
#   body = 'Hello, World!'
#
#   [200, { 'Content-Type' => 'text/plain', 'Content-Length' => body.length.to_s }, [body]]
# end

shared_root = "/mnt/app-rails/xmolexam.xiaoma.com/shared"

environment 'production'
daemonize false

pidfile "#{shared_root}/tmp/puma.pid"
state_path "#{shared_root}/tmp/puma.state"

# stdout_redirect 'log/puma.log', 'log/puma_err.log'

# quiet
threads 4, 48
bind "#{shared_root}/tmp/sockets/puma.sock"

# ssl_bind '127.0.0.1', '9292', { key: path_to_key, cert: path_to_cert }

# on_restart do
#   puts 'On restart...'
# end

# restart_command '/u/app/lolcat/bin/restart_puma'


# === Cluster mode ===

# workers 2

# on_worker_boot do
#   puts 'On worker boot...'
# end

# === Puma control rack application ===
preload_app!
activate_control_app #"#{shared_root}/tmp/pumactl.sock"

