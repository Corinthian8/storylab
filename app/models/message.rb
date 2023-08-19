# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :chat
  enum role: { system: 0, assistant: 10, user: 20 }

  def broadcast_created
    ChatroomChannel.broadcast_to(
      chat,
      {
        partial: ApplicationController.new.render_to_string(partial: 'messages/message', locals: { message: self }),
        message_id: id,
        update: false
      }
    )
  end

  def broadcast_updated
    ChatroomChannel.broadcast_to(
      chat,
      {
        partial: ApplicationController.new.render_to_string(partial: 'messages/message', locals: { message: self }),
        message_id: id,
        update: true
      }
    )
  end

  def self.for_openai(messages)
    messages.map { |message| { role: message.role, content: message.content } }
  end
end
