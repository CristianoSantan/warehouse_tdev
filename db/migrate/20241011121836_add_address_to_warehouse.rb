class AddAddressToWarehouse < ActiveRecord::Migration[7.2]
  def change
    add_column :warehouses, :address, :string
  end
end
