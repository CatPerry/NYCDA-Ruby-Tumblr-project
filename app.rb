
require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"
require "bootstrap"
require 'sendgrid-ruby'

include SendGrid

from = Email.new(email: '000.perry@gmail.com')
to = Email.new(email: '000.perry@gmail.com')


# set :database, "sqlite3:app.db"
# enable :sessions
set :sessions, true
#the session createa a cookie that is handled by the browser

configure :development do
  set :database, "sqlite3:app.db"
end

# this will ensure this will only be used on production
configure :production do
  # this environment variable is auto generated/set by heroku
  #   check Settings > Reveal Config Vars on your heroku app admin panel
  set :database, ENV["DATABASE_URL"]
end

get "/" do
  # @posts = Post.all.order("created_at DESC")
  @posts = Post.order("RANDOM()").limit(3)
  @postsImages = Post.order("RANDOM()").limit(4)
  @postsbloggers = Post.order("RANDOM()").limit(2)
  @postsbottom = Post.order("RANDOM()").limit(2)
  @usersheadshot1 = User.order("username DESC").limit(1)
  @usersheadshot2 = User.order("RANDOM()").limit(1)
  @users = User.all
  if session[:user_id]
    erb :index
  else
    erb :signed_out_homepage
  end 
  erb :index
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
  flash[:info] = "Boom! Thank you for signing up. An email has been sent to you"

  sg = SendGrid::API.new(api_key: ENV["API_KEY"])
  subject = params[:name]
  content = Content.new(type: 'text/html', 
    value: 
    '<p><strong>Epic Travelers</strong><br>
    Be bold, be epic.</p>
    
    <p><strong>Start Posting!</strong></p>
    <p>Head the the Epic Traveler Homepage and Sign In<br>
    See fellow travelers latest crazy videos and posts</p>
    <p><a href="http://localhost:4567/" target="_blank"><img src="https://s9.postimg.cc/qct0apknz/adventure-beach-clouds-165505.jpg" alt="sunset kayaking"/></a><br>'
  )

  # create mail object with from, subject, to and content, and then send it
  mail = Mail.new(from, subject, to, content)
  response = sg.client.mail._('send').post(request_body: mail.to_json)

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


#create posts
get "/posts" do
  @posts = Post.all.order("created_at DESC")
  @users = User.find(session[:user_id])
  @user_id = User.find(session[:user_id])
  erb :posts, :layout => :signed_in_homepage
end

post "/posts" do
  @user = User.find(session[:user_id]) 
  @posts = Post.find(params[:id])
  @users = User.find(session[:user_id])
  @post = Post.create(
  title: params[:title],
  author: params[:author],
  content: params[:content],
  images: params[:images],
  user_id: @user_id
  )
redirect "/posts" 
end

get "/posts/:id" do
  @posts = Post.find(params[:id])
  erb :posts, :layout => :post_id
end


get "/posts/edit/:id" do
  # if session[:user_id] && Post.find(params[:id]).user.id == session[:user_id]
    @posts = Post.find(params[:id])
    @users = User.find(session[:user_id])
    @user = User.find(session[:user_id])
    erb :posts, :layout => :edit_post
  # elsif session[:user_id] && Post.find(params[:id]).user.id != session[:user_id]
  #   flash[:warning] = "Cannot edit this post"
  #   redirect "/posts"
  # # else 
  #   flash[:warning] = "Please sign in" 
  #   redirect "/"
  # end
end

put "/posts/edit/:id" do
  @posts = Post.find(params[:id])
  @posts.update(
    title: params[:title],
    author: params[:author],
    content: params[:content],
    images: params[:images],
  ) 
  redirect "/posts"
end

#delete post
delete "/posts/delete/:id" do
  @post = Post.destroy(params[:id])  
  flash[:warning] = "Your post was deleted"
  redirect "/posts"
end

#delete user
get "/delete" do 
  erb :delete, :layout => :delete_page
end

delete "/delete" do
  @user = User.find(session[:user_id])
  @user.destroy
  redirect "/"
end

