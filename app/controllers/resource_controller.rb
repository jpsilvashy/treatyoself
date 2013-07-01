# POST /
post '/' do
  if params[:url] and not params[:url].empty?
    settings.redis.sadd 'uris', params[:url]
  end
end

# DELETE /:shortcode
delete '/:shortcode' do
  if params[:shortcode] and not params[:shortcode].empty?
    settings.redis.srem params[:shortcode]
  end
end

# GET on index
get '/' do
  redirect settings.redis.spop('uris') || '/'
end

# GET for shortcodes
get '/:shortcode' do
  redirect settings.redis.get(params[:shortcode]) || '/'
end