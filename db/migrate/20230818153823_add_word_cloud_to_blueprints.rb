class AddWordCloudToBlueprints < ActiveRecord::Migration[7.0]
  def change
    add_column :blueprints, :word_cloud, :text, array: true
  end
end
