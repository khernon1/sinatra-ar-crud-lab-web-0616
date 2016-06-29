require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #new
  get '/posts/new' do 
    erb :new    
  end

  #index
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  #show
  get '/posts/:id' do 
    @post = Post.find(params[:id])
    #binding.pry
    erb :show
    #delete button included in here 
  end

  #create
  post '/posts' do
    post = Post.create(params)
    redirect "/posts"
  end

  #edit
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end
  
  #update - 2nd part of edit that updates it
  post '/posts/:id/edit' do
    post = Post.find(params[:id])
    post.update(name: params[:name], content: params[:content])
    post.save
    redirect "/posts/#{post.id}"
  end

  #delete
  post '/posts/:id/delete' do
    post = Post.find(params[:id])
    post.destroy
    "#{post.name} was deleted"
  end

end