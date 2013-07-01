# POST /
post '/' do
  if params[:url] and not params[:url].empty?
    @shortcode = SecureRandom.hex(4)
    settings.redis.set @shortcode, params[:url]
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
  @shortcode = settings.redis.get settings.redis.randomkey
  redirect @shortcode || '/'
end

# GET for shortcodes
get '/:shortcode' do
  redirect settings.redis.get(params[:shortcode]) || '/'
end