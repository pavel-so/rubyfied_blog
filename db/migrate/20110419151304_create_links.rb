class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :href
      t.string :title
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
