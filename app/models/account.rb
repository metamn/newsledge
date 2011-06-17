# A list of user accounts associated to platforms
# These accounts will be read by Newsledge
#
class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :platform
  
  validates_uniqueness_of :name
end
