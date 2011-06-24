class Item < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :references
end
