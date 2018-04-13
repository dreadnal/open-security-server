class CreateSensorTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :sensor_types do |t|
      t.string :name
      t.string :icon
      t.string :model
      t.string :note

      t.timestamps
    end
  end
end
