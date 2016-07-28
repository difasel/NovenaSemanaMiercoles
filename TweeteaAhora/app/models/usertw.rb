class Usertw < ActiveRecord::Base
  # Remember to create a migration!
  validates :user,  uniqueness: true
  has_many :tweets
end
