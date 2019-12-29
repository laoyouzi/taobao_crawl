class AddCustomIdToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :custom_id, :string
  end
end
