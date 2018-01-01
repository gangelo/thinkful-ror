class AddNameAndEmailAndPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, limit: 32
    add_column :users, :email, :string, limit: 254
    add_column :users, :user_name, :string, limit: 16
    add_column :users, :password, :string, limit: 16
  end
end
