# noinspection ALL,RubyResolve,RubyResolve,RubyResolve,RubyResolve,RubyResolve,RubyResolve
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages/new
  def new
    if(params.has_key?(:id) and @flats =Flat.where(id:params[:id]) and @flats.present?)
      @message = Message.new
      if @flats.first.author == current_user.id
        redirect_to :back
      end
    else
      if params.has_key?(:conversation_id) and Conversation.where(id: params[:conversation_id] ).present?
        @message = Message.new
      else
       redirect_to root_path
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    respond_to do |format|
    if message_params.has_key?(:flat_id) and message_params[:flat_id] != '-1'
      @conversation = Conversation.includes(:user).find_by_flat_id(message_params[:flat_id])
      if @conversation.nil?
        @conversation = Conversation.new
        @conversation.user = User.find(current_user.id)
        @conversation.flat = Flat.find(message_params[:flat_id])
        @conversation.save
      end
      if @conversation.user.id == @conversation.flat.author
        format.html { redirect_to root_path , notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }

      end
    else
      if message_params.has_key?(:conversation_id) and message_params[:conversation_id] != '-1'
        @conversation = Conversation.find(message_params[:conversation_id])
      end
    end
    @message = Message.new()
    @message.text = message_params[:text]
    @message.conversation_id = @conversation.id
    @message.author = current_user.id
    @message.time = 5;
      if !@conversation.nil? and @message.save!
        format.html { redirect_to @conversation, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
        else
        format.html { redirect_to :back, :locals => message_params}
        format.json { render json: @messages.errors, status: :unprocessable_entity }
      end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.fetch(:message, {})
    end
end
