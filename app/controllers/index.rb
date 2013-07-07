enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/user/new' do
  erb :user_new

end

post '/user/new' do
  puts params
  user = User.create(params[:user])
  if user
    session[:user_id] = user.id
    redirect "/user/#{session[:user_id]}"
  end
  redirect "/"

end


get '/user/login' do 
  erb :user_login

end

post '/user/login' do
  # user = User.find_by_user_name(params[:user][:email])
  authenticate = User.authenticate(params[:user])
  if authenticate
    user = User.find_by_email(params[:user][:email])
    session[:user_id] = user.id
    redirect "/user/#{session[:user_id]}"
  end
  redirect '/'

end

get "/user/:id" do #user profile page
  @user = User.find(params[:id])
  if @user == current_user
    erb :user_profile
  else
    erb :user_login
  end
  
end

get '/logout' do
  session.clear
  redirect '/'
end



