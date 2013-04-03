ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'activable'
require 'generator_spec/test_case'
require 'test_app/config/environment'
require 'rake'

Dir[Pathname.new(File.expand_path('../', __FILE__)).join('support/**/*.rb')].each {|f| require f}

Dir.chdir File.expand_path("../test_app", __FILE__) do
  system 'rake db:create' unless File.exists?('db/test.sqlite3')
  system 'rake db:migrate'
end

RSpec.configure do |config|
end
