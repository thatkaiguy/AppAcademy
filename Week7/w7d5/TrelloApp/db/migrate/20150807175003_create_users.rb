class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :pw_digest
      t.string :session_token
      t.string :gravatar_url

      t.timestamps null: false
    end
  end
end
