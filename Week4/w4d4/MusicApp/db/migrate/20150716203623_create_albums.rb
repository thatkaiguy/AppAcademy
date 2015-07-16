class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :title, null: false
      t.string :recording_location, null: false

      t.timestamps
    end

    add_index :albums, :title
    add_index :albums, :band_id
  end
end
