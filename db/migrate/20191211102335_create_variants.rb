class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.integer  :product_id
      t.string   :sku
      t.integer  :quantity, default: 0, null: false
      t.decimal  :price,  precision: 6, scale: 2, default: 0.0, null: false
      t.string   :option_values

      t.timestamps
    end
  end
end
