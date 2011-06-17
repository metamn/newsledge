class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :status
      t.integer :count
      t.text :log

      t.timestamps
    end
  end
end
