class ItemsReferences < ActiveRecord::Migration
  def up
    create_table :items_references, :id => false do |t|
      t.integer :item_id
      t.integer :reference_id
    end
  end

  def down
    drop_table :items_references
  end
end
