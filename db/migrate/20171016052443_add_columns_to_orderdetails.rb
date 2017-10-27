class AddColumnsToOrderdetails < ActiveRecord::Migration[5.1]
  def change
    add_column :order_details, :price, :decimal, precision: 12, scale: 3
    add_column :order_details, :total_price, :decimal, precision: 12, scale: 3
  end
end
