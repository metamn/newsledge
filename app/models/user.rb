# Managing users logged in the system
#
# - it is created automatically by Devise
# - except Platforms all other models must be associated with current_user
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :accounts
  
  # Collecting imports for the current user through accounts
  # 
  # Returns and array of imports
  def imports
    accounts = self.accounts.map {|a| a.imports }.flatten    
  end
  
  def to_param
    "#{self.name}"
  end
end
