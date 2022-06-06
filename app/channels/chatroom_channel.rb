class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # get called whenever an user subscribe to our channel
    # stream_from "chatroom-#{params[:id]}"
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
