class AddPexelsToScripts < ActiveRecord::Migration[7.0]
  def change
    add_column :scripts, :pexels_videos, :text, array: true
  end
end
