class ChangeLinkType < ActiveRecord::Migration
  def change
    change_column :entries, :link, :text, null: false
  end
end
