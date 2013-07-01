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