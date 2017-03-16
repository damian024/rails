class AddTitleToFlat < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :title, :string
  end
end
