# noinspection ALL,RubyResolve,RubyResolve
class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @ownedFlats = Flat.where(author:current_user.id ).pluck("id")
    @conversations = Conversation.where('user_id=' +current_user.id.to_s+ ' OR flat_id IN (?)', @ownedFlats)
    @email = User.find(current_user.id).email;
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.includes(:user).find(params[:id])
    @messages = Message.find_by(:conversation  => @conversation)
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.user = User.find(current_user.id)
    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.fetch(:conversation, {})
    end
end
