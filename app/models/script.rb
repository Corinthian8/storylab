class Script < ApplicationRecord
  belongs_to :user
  belongs_to :blueprint
  validates :topic, presence: true
  validates :topic, length: { minimum: 2 }
  validates :topic, length: { maximum: 100 }

  # broadcast_replace_to(:notifications, target: "icon", html: "<span class='icon'>notification_new</span>")
  def regenerate_script
    self.script_body = ChatgptService.call("
      Create a 'technical script' for a YouTube video about #{self.topic}.
      The video should have a duration of around #{self.duration} minutes.
      It's tone should be #{self.tone}.
      Create it by following this prompt: '#{self.blueprint.prompt_template}'")
    self.save
    # add turbo stream to view
    # add turbo frame to show
    # broadcast_to
  end
end
