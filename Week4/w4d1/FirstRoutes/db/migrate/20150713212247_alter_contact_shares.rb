class AlterContactShares < ActiveRecord::Migration
  def change
    add_foreign_key :contact_shares, :contacts
    add_foreign_key :contact_shares, :users
    add_foreign_key :contacts, :users
  end
end
