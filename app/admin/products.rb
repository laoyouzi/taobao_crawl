ActiveAdmin.register Product do
  actions :all, except: [ :new ]
  permit_params :title, :spu, :custom_id, :url

  index do
    selectable_column
    id_column
    column "custom SKU" do |p|
      p.custom_id
    end
    column "产品title" do |p|
      link_to p.title, admin_variants_path(q: {product_id_equals: p.id})
    end
    column :updated_at
    column :created_at
    actions
  end

  filter :custom_id
  filter :id

end
