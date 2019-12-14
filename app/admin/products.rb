ActiveAdmin.register Product do
  actions :all, except: [ :new, :edit ]

  index do
    selectable_column
    id_column
    column "产品title" do |p|
      link_to p.title, p.url, target: "_blank"
    end
    column :spu
    column :updated_at
    column :created_at
    actions
  end

  filter :spu
  filter :id

end
