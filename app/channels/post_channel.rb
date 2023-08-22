class PostChannel < ApplicationCable::Channel
  def subscribed
    script = Script.find(params[:id])
    stream_for script
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
