class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.references :area, foreign_key: true
      t.references :sensor_type, foreign_key: true
      t.string :name
      t.string :address
      t.string :note
      t.text :data

      t.timestamps
    end
  end
end
