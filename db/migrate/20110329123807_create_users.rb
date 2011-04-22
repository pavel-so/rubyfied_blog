class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.boolean :active, :default=>false
      t.string :activation_code
      t.string :reset_code
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

