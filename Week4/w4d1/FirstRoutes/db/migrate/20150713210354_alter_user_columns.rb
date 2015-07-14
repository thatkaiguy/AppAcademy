class AlterUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :email

    add_column :users, :username, :string, null: false, default: "Need username"
  end
end
