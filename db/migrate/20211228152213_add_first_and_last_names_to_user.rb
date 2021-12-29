class AddFirstAndLastNamesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, nil: false
    add_column :users, :last_name, :string, nil: false

    add_index :users, [:first_name, :last_name]
  end
end
