class AddUserToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer
  end
end
