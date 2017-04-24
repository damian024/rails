class AddAuthorToConversation < ActiveRecord::Migration[5.0]
  def change
    add_reference :conversations, :user, foreign_key: true
  end
end
