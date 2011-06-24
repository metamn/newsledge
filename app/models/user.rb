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
  has_many :items
  has_many :tags
  has_many :references
  
  # Collecting imports for the current_user through accounts
  # 
  # Returns and array of imports
  def imports
    Import.find_all_by_account_id self.accounts
  end
  
  # Checking if a single import belongs to current_user
  #
  # id - the Import id
  #
  # Returns the Import or raises and exception caught later in ApplicationController
  def import(id)
    return Import.find(id) if Import.find(id).account.user.id == self.id
    raise ActiveRecord::RecordNotFound
  end
  
  
  # Converts :users/:id to :users/:name
  #
  # Used to generate user home urls like host/:username instead of host:/userid
  #
  # Returns :name when  params[:id] is called
  def to_param
    "#{self.name}"
  end
end
