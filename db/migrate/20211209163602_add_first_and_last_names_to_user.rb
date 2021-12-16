class AddFirstAndLastNamesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string, nil: false
    add_column :users, :last_name, :string, nil: false

    add_index :users, :first_name
    add_index :users, :last_name
  end
end
