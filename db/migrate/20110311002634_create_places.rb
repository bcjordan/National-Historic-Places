class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.float :lat
      t.float :lng
      t.text :name
      t.text :html

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
