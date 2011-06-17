class AddAccountToImport < ActiveRecord::Migration
  def change
    add_column :imports, :account_id, :integer
  end
end
