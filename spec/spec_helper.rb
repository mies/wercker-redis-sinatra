require File.join(File.dirname(__FILE__), '..', 'main.rb')

require 'sinatra'
require 'redis'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before :each do
    $redis = Redis.new(url: ENV["WERCKER_REDIS_URL"], driver: :hiredis)
  end
end