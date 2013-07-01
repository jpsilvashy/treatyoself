# POST /
post '/' do
  if params[:url] and not params[:url].empty?
    @shortcode = SecureRandom.hex(4)
    settings.redis.setnx @shortcode, params[:url]
  end
end

# DELETE /:shortcode
delete '/:shortcode' do
  if params[:shortcode] and not params[:shortcode].empty?
    settings.redis.del params[:shortcode]
  end
end

# GET on index
get '/' do
  @randomkey = settings.redis.get settings.redis.randomkey
  redirect @randomkey || '/'
end

# GET for shortcodes
get '/:shortcode' do
  @url = settings.redis.get params[:shortcode]
  redirect @url || '/'
end