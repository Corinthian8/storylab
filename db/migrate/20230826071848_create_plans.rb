class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.text :content
      t.belongs_to :script

      t.timestamps
    end
  end
end
