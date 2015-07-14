class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.integer :group_id, null: false, index: true
      t.integer :contact_id, null: false, index: true
      t.timestamps null: false
    end

    add_foreign_key :groupings, :groups
    add_foreign_key :groupings, :contacts

    add_index :groupings, [:group_id, :contact_id], unique: true
  end
end
