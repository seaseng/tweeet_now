class TwitterUser < ActiveRecord::Base
  has_many :tweets
  def fetch_tweets!

    Twitter.user_timeline(self.screen_name).each do |tweet|
      self.tweets << Tweet.find_or_create_by_tweet_id(text:       tweet.text, 
                                                      tweet_id:   tweet.id.to_s,
                                                      tweeted_at: tweet.created_at)
    end
    self.tweets
  end

  def tweets_stale?
    # tweet_time = Time.parse(self.tweets.last.tweeted_at)
    tweet_time = self.tweets.last.created_at # Time.parse not need for db timestamps
    if ((Time.now - tweet_time)/60) > 60 #1 hours since oldest tweet in db
      return true
    else
      return false
    end
  end
end
