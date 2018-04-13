class CreateCameras < ActiveRecord::Migration[5.1]
  def change
    create_table :cameras do |t|
      t.references :area, foreign_key: true
      t.string :name
      t.string :address
      t.string :note
      t.text :data

      t.timestamps
    end
  end
end
