class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :event_type, foreign_key: true
      t.references :sensor, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
