ActiveAdmin.register IpAgent do
  permit_params :name, :api, :active
  menu parent: 'Admin'
end
