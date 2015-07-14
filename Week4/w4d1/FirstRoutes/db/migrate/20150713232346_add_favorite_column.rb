class AddFavoriteColumn < ActiveRecord::Migration
  def change
    add_column :contacts, :is_favorite, :boolean, default: false
    add_column :contact_shares, :is_favorite, :boolean, default: false
  end
end
