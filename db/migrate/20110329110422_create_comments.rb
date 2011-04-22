class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.text :message
      t.string :author
      t.integer :author_id
      t.boolean :published, :default=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

