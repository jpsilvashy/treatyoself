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

# get '/:shortcode' do
#   @url = settings.redis.get params[:shortcode]
#   redirect @url || '/'
# end

images = [
  'http://blog.zap2it.com/frominsidethebox/parks-and-rec-treat-yoursel.jpg',
  'http://i52.tinypic.com/afihkh.jpg',
  'http://24.media.tumblr.com/tumblr_m8mtpz78vu1rs7wu4o1_r2_500.jpg',
  'http://michiganjournal.org/wp-content/uploads/2012/11/parks-and-rec-treat-yo-self.gif',
  'http://sherryndaniel.files.wordpress.com/2012/02/treat-to-self-2.jpg',
  'http://media.tumblr.com/tumblr_m8u0ziwt5i1rqpx0x.gif',
  'http://www.newdressaday.com/wp-content/uploads/2011/11/photo7.jpg',
  'http://25.media.tumblr.com/tumblr_lt2w75rKZO1qazkdco1_500.gif'
]

get '/random' do
  content_type :json
  images.sample.to_json
end

