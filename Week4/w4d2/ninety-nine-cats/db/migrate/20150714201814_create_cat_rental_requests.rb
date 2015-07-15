class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :cat_id
      t.string :status, default: "PENDING"

      t.timestamps null: false
    end
    add_index :cat_rental_requests, :cat_id
  end
end
