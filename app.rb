# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'json'

enable :sessions

class Message < ActiveRecord::Base
  validates :message, presence: true
  validates :destroy_type, presence: true
  validates :destroy_cond, presence: true, numericality: { only_integer: true }
  
  before_create :set_random_url, :set_destroy_time

  after_find do |message|
    if message.destroy_type.to_i == 1 && message.destroy_cond.to_i > 1
      message.destroy_cond = message.destroy_cond.to_i - 1
      message.save
    elsif message.destroy_type.to_i == 1 && message.destroy_cond.to_i == 1
      message.destroy
    end
  end

  def set_random_url  # TODO: check url for unic
    self.url = 10.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z' ].sample }.join
  end

  def set_destroy_time
    if self.destroy_type.to_i == 2
      self.destroy_time = Time.now + 60 * destroy_cond.to_i
    end
  end
end

get "/" do
  haml :index
end

post "/" do
  @message = Message.new(params[:message])
  if @message.save
    content_type :json
    @message.to_json
  else
    redirect '/', :error => 'Something went wrong. Try again.'
  end
end

get "/:url" do |url|
  @message = Message.where({:url => url}).first
  if @message
    haml :view
  else
    redirect '/', :error => 'No message with url. Possibly it was destroyed. You can create new message.'
  end
end