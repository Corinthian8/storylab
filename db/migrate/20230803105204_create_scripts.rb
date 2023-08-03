class CreateScripts < ActiveRecord::Migration[7.0]
  def change
    create_table :scripts do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :blueprint, null: false, foreign_key: true
      t.string :topic
      t.text :script_body
      t.string :tone
      t.integer :duration

      t.timestamps
    end
  end
end
