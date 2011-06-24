class ReAddItemsTags < ActiveRecord::Migration
  def up
    drop_table :items_tags
    create_table :items_tags, :id => false do |t|
      t.integer :item_id
      t.integer :tag_id
    end
  end

  def down
    drop_table :items_tags
  end
end
