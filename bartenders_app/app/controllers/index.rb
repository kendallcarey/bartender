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
  client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
                            consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                            token: ENV['YELP_TOKEN'],
                            token_secret: ENV['YELP_TOKEN_SECRET']
                          })
  @bars = client.search('633 Folsom St., San Francisco', { term: 'bar', radius: 2, limit: 5 }).businesses

  erb :show
end


post '/users' do
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect "/users/#{@user.id}"
end



