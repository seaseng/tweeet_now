enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end


post '/tweets' do 

  # debugger
  # ''
  begin 
    user = Twitter.user(params[:screen_name])
  rescue
    if request.xhr?
      erb :'/twitter/_errors', :layout => false
    else
      erb :errors
    end

  else
    user = TwitterUser.find_or_create_by_screen_name({:screen_name => user.screen_name})

    # debugger
    # ''
    if user.tweets.empty? || user.tweets_stale?
      user.fetch_tweets!
    end
    # sleep 3

    # tweets = user.tweets.limit(10)
    tweets = user.tweets.order("tweeted_at DESC").first(10)

    if request.xhr?
      erb :'/twitter/_tweets', :layout => false, :locals => { :tweets => tweets, :user => user }
    else
      erb :'/twitter/tweets', :locals => { :tweets => tweets, :user => user }
    end

  end

end

post '/tweet/send' do

  if request.xhr?
    Twitter.update(params[:tweet])
    erb :'/twitter/_tweet_sent_response', :layout => false
  end

end




# get '/test' do
#   erb :test_view
# end

# post '/test' do
#   @test = params
#   erb :test_view
# end


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



