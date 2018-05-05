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
  erb :sign_up, :layout => :sign_up_homepage
end

#here we start to user sessions
post "/sign-up" do
  @user = User.create(
    username: params[:username],
    password: params[:password],
    userimage: params[:userimage],
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    birthday: params[:birthday]
  )
  
  # this line does the signing in
  session[:user_id] = @user.id

  # lets the user know they have signed up
  flash[:info] = "Thank you for signing up"

  # assuming this page exists
  redirect "/posts"
end

# when hitting this get path via a link
#   it would reset the session user_id and redirect
#   back to the homepage
get "/sign-out" do
  # this is the line that signs a user out
  session[:user_id] = nil

  # lets the user know they have signed out
  flash[:info] = "You have been signed out"
  
  redirect "/sign-in"
end


get "/profile" do
  @user = User.find(session[:user_id])
  @posts = @user.posts
  erb :profile
end

get "/profile/:id" do
  @user = User.find(session[:user_id])
  @posts = @user.posts
end

#create posts
get "/posts" do
  @posts = Post.all
  @users = User.find(session[:user_id])
  erb :posts, :layout => :signed_in_homepage
end

post "/posts" do
@post = Post.create(
  title: params[:title],
  author: params[:author],
  content: params[:content],
  images: params[:images],
  user_id: params[:user_id]
  )
redirect "/" 
end

#delete post
delete "/posts/:id/delete" do
  @post = Post.find_by_id(params[:id])  
  @post.delete
  redirect "/profile"
end

#delete user
get "/delete" do 
  erb :delete
end

delete "/delete" do
  @user = User.find(session[:user_id])
  @user.destroy
  redirect "/login"
end

# edit post inspired by http://mherman.org/blog/2013/06/08/designing-with-class-sinatra-plus-postgresql-plus-heroku/#edit-posts
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  @title = "Edit Form"
  erb :"posts/edit"
end

post "/posts/:id" do
  @posts = Post.find(params[:id])
  @post.update(params[:post])
  redirect "/posts/#{@post.id}"
end