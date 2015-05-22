require 'rubygems'
require 'bundler'
# require 'active_support'
require 'active_record'


begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
# 
# task :environment do
#   ENV['RACK_ENV'] ||= 'development'
#   require File.expand_path('../config/environment', __FILE__)
# end


# task routes: :environment do
#   Acme::API.routes.each do |route|
#     method = route.route_method.ljust(10)
#     path = route.route_path
#     puts "     #{method} #{path}"
#   end
# end
#

def get_env name, default=nil
  ENV[name] || ENV[name.downcase] || default
end
namespace :db do
  desc "prepare environment (utility)"
  task :env do
    # require 'bundler'
    env = get_env 'RACK_ENV', 'development'
    Bundler.require :default, env.to_sym
    unless defined?(DB_CONFIG)
      databases = YAML.load_file File.dirname(__FILE__) + '/config/database.yml'
      DB_CONFIG = databases[env]
    end
    puts "loaded config for #{env}"
  end

  desc "connect db (utility)"
  task connect: :env do
    "connecting to #{DB_CONFIG['database']}"
    ActiveRecord::Base.establish_connection DB_CONFIG
  end

  desc "create db for current RACK_ENV"
  task create: :env do
    puts "creating db #{DB_CONFIG['database']}"

    # ActiveRecord::Base.establish_connection DB_CONFIG.merge('database' => nil)
    ActiveRecord::Base.establish_connection DB_CONFIG
    ActiveRecord::Base.connection.create_database DB_CONFIG['database'], charset: 'utf8'
    ActiveRecord::Base.establish_connection DB_CONFIG
    
  end

  desc 'drop db for current RACK_ENV'
  task drop: :env do
    if get_env('RACK_ENV') == 'production'
      puts "cannot drop production database!"
    else
      puts "dropping db #{DB_CONFIG['database']}"
      ActiveRecord::Base.establish_connection DB_CONFIG.merge('database' => nil)
      ActiveRecord::Base.connection.drop_database DB_CONFIG['database']
    end
  end

  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migration => :connect do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  desc 'run migrations'
  task migrate: :connect do
    version = get_env 'VERSION'
    version = version ? version.to_i : nil
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate 'db/migrate', version
  end

  desc 'rollback migrations (STEP = 1 by default)'
  task rollback: :connect do
    step = get_env 'STEP'
    step = step ? step.to_i : 1
    ActiveRecord::Migrator.rollback 'db/migrate', step
  end

  desc "show current schema version"
  task version: :connect do
    puts ActiveRecord::Migrator.current_version
  end
end

# namespace :metric do
#   desc "project statistics"
#   task 'stat' do
#     puts "\nRuby:"
#     stat_files Dir.glob('**/*.rb') - Dir.glob('test/**/*.rb')
#   end
# end
#
# private
# def stat_files fs
#   c = 0
#   fc = 0
#   fs.each do |f|
#     fc += 1
#     data = File.binread f
#     c += data.count "\n"
#   end
#   puts "files: #{fc}"
#   puts "lines: #{c}"
# end
