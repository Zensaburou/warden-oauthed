ENV['RACK_ENV'] ||= 'development'

begin
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end

Bundler.require(:runtime)

file_dir = File.dirname(__FILE__)
$LOAD_PATH << file_dir + '/lib'
require File.expand_path(File.join(file_dir, 'lib', 'warden-oauthed'))
require File.expand_path(File.join(file_dir, 'spec', 'app'))

run Example.app
