# Rakefile

require './app'
require 'sinatra/activerecord/rake'

task :destroy_messages_by_time do
  puts "Destroing messages by time."
  Message.where('destroy_time < ?', Time.now).destroy_all
end