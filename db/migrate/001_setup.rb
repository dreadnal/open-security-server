class Setup < ActiveRecord::Migration[5.1]
  def self.up
    create_table :floors do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

    create_table :areas do |t|
      t.references :floor, foreign_key: true
      t.string :name
      t.text :verticles

      t.timestamps
    end

    create_table :sensor_types do |t|
      t.string :name
    end

    create_table :system_modules do |t|
      # Base attributes
      t.references :area, foreign_key: true
      t.string :name
      t.string :type
      t.float :position_x
      t.float :position_y
      t.float :position_z
      t.float :rotation_x
      t.float :rotation_y
      t.float :rotation_z

      # Child attributes
      t.references :sensor_type, foreign_key: true
      t.string :address
      t.string :api_key

      t.timestamps
    end

    create_table :event_types do |t|
      t.string :name
      t.string :ref_name

      t.timestamps
    end

    create_table :events do |t|
      t.references :event_type, foreign_key: true
      t.references :sensor, foreign_key: true

      t.string :state

      t.timestamps
    end

    create_table :devices do |t|
      t.string :name
      t.boolean :verified
      t.string :api_key
      t.string :one_time_password

      t.timestamps
    end

    create_table :preferences do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :events
    drop_table :event_types
    drop_table :system_modules
    drop_table :sensor_types
    drop_table :areas
    drop_table :floors
    drop_table :devices
    drop_table :preferences
  end
end
