# frozen_string_literal: true

class CreateBlueprints < ActiveRecord::Migration[7.0]
  def change
    create_table :blueprints do |t|
      t.string :name
      t.text :prompt_template
      t.text :sample_videos, array: true, default: []

      t.timestamps
    end
  end
end
