class CreateIpClients < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_agents do |t|
      t.string  :name
      t.string  :api
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
