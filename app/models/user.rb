# Managing users logged in the system
#
# - it is created automatically by Devise
# - except Platforms all other models must be associated with current_user
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :accounts
  
  # Collecting imports for the current user through accounts
  # 
  # Returns and array of imports
  def imports
    accounts = self.accounts.map {|a| a.imports }.flatten    
  end
end
