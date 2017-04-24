# noinspection ALL,RubyResolve
class CreateFlats < ActiveRecord::Migration[5.0]
  def change
    create_table :flats do |t|
      t.float :size
      t.decimal :price
      t.integer :rooms
      t.text :description

      t.timestamps
    end
  end
end
