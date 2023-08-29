class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.text :content
      t.references :script, null: false, foreign_key: true

      t.timestamps
    end
  end
end
