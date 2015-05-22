ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

require File.expand_path('../application', __FILE__)

