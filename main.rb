require 'sinatra'
require 'redis'

configure :production do
    uri = URI.parse(ENV["REDISGREEN_URL"])
    $redis = Redis.new(url: ENV["REDISGREEN_URL"], driver: :hiredis)
end

configure :test do
    $redis = Redis.new(url: ENV["WERCKER_REDIS_URL"], driver: :hiredis)
end

configure :development do
  $redis = Redis.new()
end


get '/' do
  decepticons = $redis.smembers('decepticons')
  return decepticons
end

get '/add' do
  erb :new
end

post '/add' do
  $redis.sadd('decepticons', 'starscream')
  redirect '/'
end