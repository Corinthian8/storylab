class AddDescriptionToBlueprints < ActiveRecord::Migration[7.0]
  def change
    add_column :blueprints, :description, :text
  end
end
