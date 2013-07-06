enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end
