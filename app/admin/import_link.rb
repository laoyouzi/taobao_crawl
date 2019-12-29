ActiveAdmin.register_page "ImportLink" do
  menu priority: 2, label: proc { I18n.t("active_admin.import_url", default: "导入链接") }

  content title: proc { "" } do
    render partial: 'url'
  end

  controller do
    def create

    end
  end

end
