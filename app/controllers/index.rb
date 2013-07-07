enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/test' do
  erb :test_view
end

post '/test' do
  @test = params
  erb :test_view
end


get '/user/new' do
  erb :'/user/user_new'

end

post '/user/new' do
  puts params
  user = User.create(params[:user])
  if user.valid?
    session[:user_id] = user.id
    redirect "/user/#{session[:user_id]}"
  else
    puts "Errors: #{user.errors.full_messages}"
    @error_messages = user.errors.full_messages
    erb :'/user/user_new'
  end


end


get '/user/login' do 
  erb :'/user/user_login'

end

post '/user/login' do
  # user = User.find_by_user_name(params[:user][:email])
  authenticate = User.authenticate(params[:user])
  if authenticate
    user = User.find_by_email(params[:user][:email])
    session[:user_id] = user.id
    redirect "/user/#{session[:user_id]}"
  else
    @login_messages = :failed_login
    erb :'/user/user_login'
  end

end

get "/user/:id" do #user profile page
  @user = User.find(params[:id])
  if @user == current_user
    erb :'/user/user_profile'
  else
    erb :'/user/user_login'
  end

end

get '/logout' do
  session.clear
  @errors_messages = nil
  redirect '/'
end



