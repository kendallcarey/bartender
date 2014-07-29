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
  erb :user
end


post '/users' do
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect "/users/#{@user.id}"
end