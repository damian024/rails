class RemoveAuthorFromConversation < ActiveRecord::Migration[5.0]
  def change
    remove_column :conversations, :author, :integer
  end
end
