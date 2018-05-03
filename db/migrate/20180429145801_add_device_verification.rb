class AddDeviceVerification < ActiveRecord::Migration[5.1]
  def self.up
    add_column :devices, :verified, :boolean
    add_column :devices, :one_time_password, :string
    add_column :sensors, :verified, :boolean
    add_column :sensors, :one_time_password, :string
  end

  def self.down
    remove_column :devices, :verified
    remove_column :devices, :one_time_password
    remove_column :sensors, :verified
    remove_column :sensors, :one_time_password
  end
end
