#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:blog.db"

class Post < ActiveRecord::Base
	has_many :comments
	validates :author, presence: true
	validates :text, presence: true, length: { minimum: 3 }
end

class Comment < ActiveRecord::Base
	belongs_to :post
	validates :author, presence: true
	validates :text, presence: true, length: { minimum: 2 }
end

before do
	@posts = Post.all
end

get '/' do
	@posts = Post.order "created_at DESC"
	erb :index
end

get '/new' do
	@p = Post.new
	erb :new
end

post '/new' do
	@p = Post.new params[:post]
	if @p.save
		erb "<h2>New post added</h2>"
	else
		@error = @p.errors.full_messages.first
		erb :new
	end
end

get '/details/:id' do
	@post = Post.find(params[:id])
	@comments = @post.comments "created_at DESC"
	@c = Comment.new
	erb :details
end

post '/details/:id' do
	@post = Post.find(params[:id])
	@c = @post.comments.new params[:comment]
	if @c.save
		erb "<h4>New comment added</h4>"
	else

		@error = @c.errors.full_messages.first
		@post = Post.find(params[:id])
		@comments = @post.comments "created_at DESC"
		erb :details


	end
end

