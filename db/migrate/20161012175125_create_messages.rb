class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :message
      t.string :url
      t.string :destroy_type
      t.string :destroy_cond
      t.datetime :destroy_time
      t.timestamps
    end
 end

 def self.down
   drop_table :messages
 end
end