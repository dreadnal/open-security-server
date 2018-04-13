class CreateFloors < ActiveRecord::Migration[5.1]
  def change
    create_table :floors do |t|
      t.string :name
      t.integer :position
      t.text :data

      t.timestamps
    end
  end
end
