class CreateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|
      t.references :floor, foreign_key: true
      t.string :name
      t.text :data

      t.timestamps
    end
  end
end
