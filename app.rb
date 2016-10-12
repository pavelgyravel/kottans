# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

enable :sessions

class Message < ActiveRecord::Base
  validates :message, presence: true
  validates :destroy_type, presence: true
  validates :destroy_cond, presence: true, numericality: { only_integer: true }
  before_create :set_random_url

  def set_random_url  # TODO: check url for unic
    self.url = 10.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z' ].sample }.join
  end
end

get "/" do
  @message = Message.where({:url => "A8AJWgI9wL"}).first
  haml :index
end

post "/" do
  @message = Message.new(params[:message])
  if @message.save
    haml :index
  else
    redirect '/', :error => 'Something went wrong. Try again. (This message will disapear in 4 seconds.)'
  end
end

get "/test" do
  
end