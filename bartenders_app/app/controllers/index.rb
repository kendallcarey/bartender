get '/' do
  erb :index
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

get '/users/#{@user.id}' do
  var = VAR.find(params[:id])
  erb :user
end

get '/signup' do
  erb :sign_up
end

post '/user/new' do
  @user = User.create(params[:name], params[:email], params[:password])
    redirect "/user/#{user.id}"
end