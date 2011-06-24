class ItemsTags < ActiveRecord::Migration
  def up
    create_table :items_tags, :id => false do |t|
      t.references :items, :null => false
      t.references :tags, :null => false
    end
  end

  def down
    drop_table :items_tags
  end
end
