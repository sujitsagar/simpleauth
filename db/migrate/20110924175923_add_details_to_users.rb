class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, :null => false
    add_column :users, :lastname, :string, :null => false
    add_column :users, :sex, :string, :null => false
    add_column :users, :city_id, :string, :default => 1, :null => false
    add_column :users, :status, :integer, :default => 0, :null => false
    add_column :users, :dateofbirth, :date
    add_column :users, :phonenumber, :string
    add_column :users, :lastloginip, :string
    add_column :users, :confirmation, :string
    add_column :users, :active, :boolean, :default => 0
    add_index :users, :city_id
  end
end
