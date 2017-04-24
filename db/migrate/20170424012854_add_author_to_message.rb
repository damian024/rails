class AddAuthorToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :author, :integer
  end
end
