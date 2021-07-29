class AddProfileAndAddressToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :address, :string, limit: 30
    add_column :users, :profile, :string
    add_column :users, :username, :string, limit: 30
  end

  def down
    remove_column :users, :address, :string
    remove_column :users, :profile, :string
    remove_column :users, :username
  end
end
