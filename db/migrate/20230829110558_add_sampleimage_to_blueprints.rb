class AddSampleimageToBlueprints < ActiveRecord::Migration[7.0]
  def change
    add_column :blueprints, :sampleimage, :string
  end
end
