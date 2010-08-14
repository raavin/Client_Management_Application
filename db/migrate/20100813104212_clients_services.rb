class ClientsServices < ActiveRecord::Migration
  def self.up
    create_table "clients_services", :id => false do |t|
      t.column "client_id", :integer
      t.column "service_id", :integer
    end
    add_index "clients_services", "client_id"
    add_index "clients_services", "service_id"
  end

  def self.down
    drop_table "clients_services"
  end
end
