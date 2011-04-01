class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.decimal :lat, :precision => 10, :scale => 6
      t.decimal :lng, :precision => 10, :scale => 6
      t.text :name
      t.text :html

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
