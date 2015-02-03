get '/' do
  erb :index
end

get '/users/new' do
  erb :sign_up
end

get '/render-partial' do
  p erb :_bar, layout: false
end

get '/show_bars/:coordinates' do
  client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
    consumer_secret: ENV['YELP_CONSUMER_SECRET'],
    token: ENV['YELP_TOKEN'],
    token_secret: ENV['YELP_TOKEN_SECRET']
    })

  coordinates = {}
  coords = params[:coordinates].split(",")
  coordinates[:latitude] = coords[0]
  coordinates[:longitude] = coords[1]

  @bars = client.search_by_coordinates(coordinates, { term: 'bar', radius: 1, limit: 16 }).businesses


  erb :_show, layout: false
end

def create(params)
  @user = User.new(name: params[:name], email: params[:email])
  @user.password = params[:password]
  @user.save!
  return @user
end

post '/users' do
  @user = create(params)
  # @user = User.create
  redirect "/users/#{@user.id}"
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :show
end

get '/users/:id/update_bars' do
  content_type :JSON
  begin
    client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
      consumer_secret: ENV['YELP_CONSUMER_SECRET'],
      token: ENV['YELP_TOKEN'],
      token_secret: ENV['YELP_TOKEN_SECRET']
      })
  rescue OpenURI::HTTPError => e
    p" Open URI error #{e.inspect}"
  rescue StandardError => e
    p "Standard Error #{e.inspect}"
  end
  coordinates = {}
  coords = params[:coordinates].split(",")
  coordinates[:latitude] = coords[0]
  coordinates[:longitude] = coords[1]

  @bars = client.search_by_coordinates(coordinates, { term: 'bar', radius: 1, limit: 16 }).businesses
  bar_address = []
  @bars.each do |bar|
    bar_address << (bar.location.address[0] + ", San Francisco, CA")
  end
  bar_address.map! do |address|
    Geocoder.coordinates(address)
  end
  var = {bars: bar_address}.to_json
  p var
end


post '/sessions' do
  @notice = env['x-rack.flash'].notice
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    env['x-rack.flash'].notice = new_event.errors.full_messages
    redirect '/'
  end
end

# get '/users/:user_id/bar/:bar_id' do
#   p params[:user_id]
#   p params[:bar_id]
#   @user = User.find(params[:user_id])
#   client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
#                             consumer_secret: ENV['YELP_CONSUMER_SECRET'],
#                             token: ENV['YELP_TOKEN'],
#                             token_secret: ENV['YELP_TOKEN_SECRET']
#                           })
#   puts "Client: #{client}"
#   puts params
#   @bar = client.search("San Francisco, CA" , { term: "bar", id: "southside-spirit-house-san-francisco" }, limit: 1).businesses
#   p @bar
#   erb :bar
# end





