class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.decimal :lat, :precision => 10, :scale => 6
      t.decimal :lng, :precision => 10, :scale => 6
      t.text :ip
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
