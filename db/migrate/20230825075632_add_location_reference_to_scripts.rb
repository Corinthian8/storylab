class AddLocationReferenceToScripts < ActiveRecord::Migration[7.0]
  def change
    add_reference :scripts, :location, foreign_key: true
  end
end
