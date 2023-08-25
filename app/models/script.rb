class Script < ApplicationRecord
  belongs_to :user
  belongs_to :blueprint
  validates :topic, presence: true
  validates :topic, length: { minimum: 2 }
  validates :topic, length: { maximum: 100 }
  # broadcast_replace_to(:notifications, target: "icon", html: "<span class='icon'>notification_new</span>")
  def regenerate_script
    self.script_body = ChatgptService.call("
      Rewrite the following 'technical script' for a YouTube video about #{topic}:
      '#{script_body}'
      Make sure the new version has a #{tone} tone, and the video made from this script should be #{duration} minutes long.")
    save
    # add turbo stream to view
    # add turbo frame to show
    # broadcast_to
  end
end
