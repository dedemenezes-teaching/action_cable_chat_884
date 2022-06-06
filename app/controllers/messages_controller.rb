class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    # message needs a chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message.chatroom = @chatroom
    # message needs an user
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string({ partial: 'message', locals: { message: @message } })
      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render 'chatrooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
