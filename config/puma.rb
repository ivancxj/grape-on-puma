#!/usr/bin/env puma

# environment ENV['RAILS_ENV'] || 'production'
environment 'development'
daemonize false

wd          = File.expand_path('../../', __FILE__)
tmp_path    = File.join(wd, 'log')
Dir.mkdir(tmp_path) unless File.exist?(tmp_path)

pidfile          File.join(tmp_path, 'puma.pid')
state_path       File.join(tmp_path, 'puma.state')
stdout_redirect  File.join(tmp_path, 'puma.out.log'), File.join(tmp_path, 'puma.err.log'), true

threads 0, 16
bind 'tcp://0.0.0.0:3000'
workers 0

preload_app!