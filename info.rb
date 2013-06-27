require 'sinatra'
require 'json'

images = [
  'http://blog.zap2it.com/frominsidethebox/parks-and-rec-treat-yoursel.jpg',
  'http://i52.tinypic.com/afihkh.jpg',
  'http://24.media.tumblr.com/tumblr_m8mtpz78vu1rs7wu4o1_r2_500.jpg',
  'http://michiganjournal.org/wp-content/uploads/2012/11/parks-and-rec-treat-yo-self.gif',
  'http://sherryndaniel.files.wordpress.com/2012/02/treat-to-self-2.jpg',
  'http://shawnaleeann.com/wp-content/uploads/2012/09/aziz.bmp',
  'http://media.tumblr.com/tumblr_m8u0ziwt5i1rqpx0x.gif',
  'http://www.newdressaday.com/wp-content/uploads/2011/11/photo7.jpg',
  'http://25.media.tumblr.com/tumblr_lt2w75rKZO1qazkdco1_500.gif'
]

get '/image.json' do
  content_type :json
  images.sample.to_json
end

get '/' do
  send_file images.sample
end
