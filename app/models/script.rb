class Script < ApplicationRecord
  belongs_to :user
  belongs_to :blueprint
end