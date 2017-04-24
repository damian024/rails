class RemoveEmailFromConversation < ActiveRecord::Migration[5.0]
  def change
    remove_column :conversations, :email, :string
  end
end
