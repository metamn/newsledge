class Tag < ActiveRecord::Base
  has_and_belongs_to_many :items
  belongs_to :user
  
  validates_uniqueness_of :name
end
