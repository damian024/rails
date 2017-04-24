# noinspection ALL
module ConversationsHelper

  def get(flat_id)
    @conversation = Conversation.where(flat_id:params[:flat_id])
    if(@conversation.nil?)
      @conversation.flat_id = params[:flat_id]
      @conversation.author = current_user.id
      @conversation.save
     end
  end
end
