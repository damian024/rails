class AddAuthorToFlat < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :author, :integer
  end
end
