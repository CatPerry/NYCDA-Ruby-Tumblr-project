require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"
require "bootstrap"

set :database, "sqlite3:app.db"
# enable :sessions
set :sessions, true
#the session createa a cookie that is handled by the browser, ti creates a ra.csession

configure :development do
  set :database, "sqlite3:app.db"
end

# this will ensure this will only be used on production
configure :production do
  # this environment variable is auto generated/set by heroku
  #   check Settings > Reveal Config Vars on your heroku app admin panel
  set :database, ENV["DATABASE_URL"]
end


# Note you CAN define Class here, but for this project, we are defining it in project

get "/" do
  if session[:user_id]
    erb :index
  else
    erb :signed_out_homepage
  end
end

# displays sign in form
get "/sign-in" do
  erb :sign_in, :layout => :sign_in_homepage
end

# responds to sign in form
post "/sign-in" do
  @user = User.find_by(username: params[:username])

  # checks to see if the user exists
  #   and also if the user password matches the password in the db
  if @user && @user.password == params[:password]
    # this line signs a user in
    session[:user_id] = @user.id

    # lets the user know that something is wrong
    flash[:info] = "You have been signed in"

    # redirects to the home page
    redirect "/posts"
  else
    # lets the user know that something is wrong
    flash[:warning] = "Your username or password is incorrect"

    # if user does not exist or password does not match then
    #   redirect the user to the sign in page
    redirect "/sign-in"
  end
end

# displays signup form
#   with fields for relevant user information like:
#   username, password
get "/sign-up" do
  erb :sign_up
end

#here we start to user sessions
post "/sign-up" do
  @user = User.create(
    username: params[:username],
    password: params[:password]
  )
  
  # this line does the signing in
  session[:user_id] = @user.id

  # lets the user know they have signed up
  flash[:info] = "Thank you for signing up"

  # assuming this page exists
  redirect "/"
end

# when hitting this get path via a link
#   it would reset the session user_id and redirect
#   back to the homepage
get "/sign-out" do
  # this is the line that signs a user out
  session[:user_id] = nil

  # lets the user know they have signed out
  flash[:info] = "You have been signed out"
  
  redirect "/"
end


#Create a post page
# if sesssion[user_id] = nill
get "/profile" do
  # if session[:user_id]
  erb :profile, :layout => :signed_in_homepage
  # end 
end

 post "/profile" do
  erb :profile, :layout => :signed_in_homepage
  puts "Hello world"
 end

#use an if statement to see if a user is signed in

#we can treate th path after prfile ad a variable doing the following
get "/profile/:id" do
 @users = User.find(params[:id])
end

# get "/profile/:username" do
#  @users = User.find(params[:username])
# end

get "/profile" do
   @users = User.find(session[:user_id])
  erb :posts
end


get "/posts" do
  @posts = Post.all
  @users = User.find(session[:user_id])
  erb :signed_in_homepage
end

post "/posts" do
@post = Post.create(
  title: params[:title],
  content: params[:content],
  # image: params[:image],
  user_id: params[:user_id]
  )
redirect "/" 
end