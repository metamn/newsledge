# Storing user accounts for different platforms
# These accounts will be read by Newsledge
class Account < ActiveRecord::Base
  validates_uniqueness_of :name
  
  belongs_to :user
  belongs_to :platform
  has_many :imports
end
