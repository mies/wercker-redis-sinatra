require 'sinatra'
require 'redis'
require 'json'
require 'pp'

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
  "Transform!"
end

get '/decepticons.json' do
  content_type :json
  decepticons = $redis.smembers('decepticons')
  return decepticons.to_json
end

get '/add' do
  erb :new
end

post '/add' do
  data = JSON.parse(request.body.read)
  $redis.sadd('decepticons', data["decepticon"])
  redirect '/'
end