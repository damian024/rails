class AddEmailToConversation < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :email, :string
  end
end
