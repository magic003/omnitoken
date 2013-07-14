ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

begin
  require 'omnitoken_app'
rescue LoadError
  require File.join(File.expand_path(File.dirname(__FILE__)), %w{.. omnitoken_app})
end

