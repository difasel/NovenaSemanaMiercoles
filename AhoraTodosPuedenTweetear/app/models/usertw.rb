class Usertw < ActiveRecord::Base
  # Remember to create a migration!
  validates :user,  uniqueness: true
  has_many :tweets

  def cliente
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "nfPgdwQB4sscL3tVQb9R2HQVk"
      config.consumer_secret     = "AXvAEzEHYjxNS1U3uI6O78Ts7QHnAR6EnXeBZx3fWcKtjuSxhs"
      config.access_token        = self.access_token
      config.access_token_secret = self.access_token_secret
    end
  client
  end

end
