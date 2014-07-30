get '/' do
  erb :index
end

# post '/sessions' do
#   @notice = env['x-rack.flash'].notice
#   @user = User.find_by_email(params[:email])
#     if @user.password == params[:password]
#       session[:user_id] = @user.id
#       redirect "/users/#{@user.id}"
#   else
#     env['x-rack.flash'].notice = new_event.errors.full_messages
#     redirect '/'
#   end
# end
get '/users/new' do
  erb :sign_up
end

get '/users/:id' do
  @user = User.find(params[:id])
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
  @bars = client.search('633 Folsom St., San Francisco', { term: 'bar', radius: 1, limit: 16 }).businesses

  erb :show
end

get '/users/:user_id/bar/:bar_id' do
  p params[:user_id]
  p params[:bar_id]
  @user = User.find(params[:user_id])
  client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
                            consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                            token: ENV['YELP_TOKEN'],
                            token_secret: ENV['YELP_TOKEN_SECRET']
                          })
  puts "Client: #{client}"
  puts params
  @bar = client.search("San Francisco, CA" , { term: "bar", id: "southside-spirit-house-san-francisco" }, limit: 1).businesses
  p @bar
  erb :bar
end


post '/users' do
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect "/users/#{@user.id}"
end



