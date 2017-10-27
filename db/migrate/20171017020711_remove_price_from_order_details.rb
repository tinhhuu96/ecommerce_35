class RemovePriceFromOrderDetails < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_details, :price, :decimal, precision: 12, scale: 3
  end
end
