ActiveAdmin.register Variant do
  actions :all, except: [:new]
  permit_params :product_id, :sku, :quantity, :price, :option_values, :status
  config.sort_order = 'updated_at_desc'

  scope :instock, group: :stock
  scope :unstock, group: :stock

  scope :instock_with_pending, group: :status
  scope :unstock_with_pending, default: true, group: :status

  index do
    selectable_column
    id_column
    column "custom SKU" do |p|
      p.product.custom_id
    end
    column "产品title" do |p|
      link_to p.product.title, p.product.url, target: "_blank"
    end
    tag_column :status, interactive: true
    column "数量" do |p|
      p.quantity
    end
    column "单价" do |p|
      p.price
    end
    column "尺码颜色" do |p|
      p.option_values
    end
    column :updated_at
    column :created_at
    actions
  end

  filter :sku
  filter :product_id

end
