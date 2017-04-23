class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :conversation, foreign_key: true
      t.datetime :time
      t.boolean :readed
      t.text :text

      t.timestamps
    end
  end
end
