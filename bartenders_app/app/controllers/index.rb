get '/' do
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  VAR.create(params)
  redirect to('/')
end

get '/show/:id' do
  var = VAR.find(params[:id])
end
