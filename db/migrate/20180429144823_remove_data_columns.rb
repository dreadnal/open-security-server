class RemoveDataColumns < ActiveRecord::Migration[5.1]
  def self.up
    remove_column :floors, :data
    remove_column :areas, :data
    remove_column :cameras, :data
    remove_column :sensors, :data
  end

  def self.down
    add_column :floors, :data, :text
    add_column :areas, :data, :text
    add_column :cameras, :data, :text
    add_column :sensors, :data, :text
  end
end
