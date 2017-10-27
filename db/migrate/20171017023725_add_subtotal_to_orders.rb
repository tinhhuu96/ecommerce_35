class AddSubtotalToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :subtotal, :string
  end
end
