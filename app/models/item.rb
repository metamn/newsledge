class Item < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :references
  
  def self.save(items, account)
    items.each do |item|
      i = Item.new
      i.account = account
      i.content = item.text
      i.link = "http://twitter.com/#!/#{item.user.name}/status/#{item.id_str}"
      i.date = item.created_at
      i.user_id = account.user_id
      
      item.entities.hashtags.each do |hashtag| 
        tag = Tag.new :name => hashtag.text
        tag.user_id = account.user_id
        i.tags << tag
      end
      
      item.entities.user_mentions.each do |mention| 
        ref = Reference.new :name => mention.id_str
        ref.user_id = account.user_id
        i.references << ref
      end
      
      i.save!
    end
  end
end
