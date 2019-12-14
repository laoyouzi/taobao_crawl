class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.string :spu
      t.string :url
      t.timestamps
    end
  end
end
