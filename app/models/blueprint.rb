class Blueprint < ApplicationRecord
  has_many :scripts
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :prompt_template, presence: true
end
