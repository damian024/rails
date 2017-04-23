class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.references :flat, foreign_key: true
      t.integer :author

      t.timestamps
    end
  end
end
