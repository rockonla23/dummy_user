enable :sessions

def login?
  if session[:username].nil?
    return false
  else
    return true
  end
end

def username
  return session[:username]
end

get '/' do
 erb :index
end

post '/login' do 
  @user = User.authenticate(params[:email], params[:password])
   if @user
     session[:username] = @user[:username]
     redirect '/'
   else
     erb :invalid
   end
end

get '/logout' do
  session[:username] = nil
  redirect "/"
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   if !@user.new_record? #Returns true if this object hasn’t been saved yet
     session[:username] = params[:username]
     redirect "/"
  else
     @error_msg = @user.errors.full_messages
     erb :signup
  end
end

get '/secure' do 
  if !login?
    redirect "/"
  else
    erb :secure
  end
end


