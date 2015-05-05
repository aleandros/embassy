ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'rack/test'

Minitest::Reporters.use!

Dir[File.dirname(__FILE__) + '/../lib/**/*.rb'].each do |rb_file|
  require rb_file
end

Dir[File.dirname(__FILE__) + '/fixtures/**/*.rb'].each do |rb_file|
  require rb_file
end
