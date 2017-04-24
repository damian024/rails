# noinspection ALL,RubyResolve,RubyResolve,RubyResolve,RubyResolve,RubyResolve,RubyResolve
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    if(params.has_key?(:id) and Flat.where(id:params[:id] ).present?)
      @message = Message.new
    else
      if params.has_key?(:conversation_id) and Conversation.where(id: params[:conversation_id] ).present?
        @message = Message.new
      else
       redirect_to root_path
      end
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    respond_to do |format|
      if message_params.has_key?(:flat_id) and message_params[:flat_id] != '-1'
        @conversation = Conversation.find_by_flat_id(message_params[:flat_id])
        if @conversation.nil?
          @conversation = Conversation.new
          @conversation.user = User.find(current_user.id)
          @conversation.flat = Flat.find(message_params[:flat_id])
            if !@conversation.save
              format.html { redirect_to flat_path(message_params[:flat_id])}
              format.json { render json: @conversation.errors, status: :unprocessable_entity }
            end
          end
      else
        @conversation = Conversation.find(message_params[:conversation_id])
        if @conversation.nil?
          format.html { redirect_to flat_path(message_params[:flat_id])}
          format.json { render json: @conversation.errors, status: :unprocessable_entity }
        end
      end

      @message = Message.new
      @message.text = message_params[:text]
      @message.conversation_id = @conversation
      @message.author = current_user.id
      if @message.save
        format.html { redirect_to @conversation, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { redirect_to new_message_path(:conversation_id => @conversation.id) }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
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
