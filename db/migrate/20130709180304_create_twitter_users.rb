class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t| 
      t.string  :screen_name
      # t.integer :friend_count
      # t.integer :total_tweets
    end
  end
end
