class PostChannel < ApplicationCable::Channel
  def subscribed
    id = params[:id]
    stream_for "post_#{id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
