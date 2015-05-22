$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '.', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '.', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require File.expand_path('../config/environment', __FILE__)

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run YC::App.instance