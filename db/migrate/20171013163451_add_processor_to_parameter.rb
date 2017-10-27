class AddProcessorToParameter < ActiveRecord::Migration[5.1]
  def change
    add_column :parameters, :processor, :string
  end
end
