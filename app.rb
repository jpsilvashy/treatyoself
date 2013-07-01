require 'sinatra'
require 'redis'
require 'json'

redis = Redis.new

configure do
  redis_url = ENV["REDISTOGO_URL"] || "redis://localhost:6379"
  uri = URI.parse(redis_url)
  set :redis, Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

post '/' do
  if params[:url] and not params[:url].empty?
    @shortcode = SecureRandom.hex(4)
    settings.redis.setnx @shortcode, params[:url]
  end
end

get '/' do
  @randomkey = settings.redis.get settings.redis.randomkey
  redirect @randomkey || '/'
end

get '/:shortcode' do
  @url = settings.redis.get params[:shortcode]
  redirect @url || '/'
end

