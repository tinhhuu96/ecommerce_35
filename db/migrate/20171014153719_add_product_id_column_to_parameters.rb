class AddProductIdColumnToParameters < ActiveRecord::Migration[5.1]
  def change
    add_column :parameters, :product_id, :integer
    add_index :parameters, :product_id
  end
end
