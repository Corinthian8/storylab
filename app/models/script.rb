class Script < ApplicationRecord
  belongs_to :user
  belongs_to :blueprint
  validates :topic, presence: true
  validates :topic, length: { minimum: 2 }
  validates :topic, length: { maximum: 100 }
end
