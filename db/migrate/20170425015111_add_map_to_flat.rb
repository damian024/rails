class AddMapToFlat < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :longitude, :float
    add_column :flats, :latitude, :float
  end
end
