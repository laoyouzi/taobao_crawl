ActiveAdmin.register Variant do
  actions :all, except: [:new, :edit, :destroy ]
  scope :instock
  scope :unstock

  index do
    selectable_column
    id_column
    column "产品title" do |p|
      link_to p.product.title, p.product.url, target: "_blank"
    end
    column "数量" do |p|
      p.quantity
    end
    column "单价" do |p|
      p.price
    end
    column "尺码颜色" do |p|
      p.option_values
    end
    column :sku
    column :updated_at
    column :created_at
    actions
  end

  filter :sku
  filter :product_id

end
