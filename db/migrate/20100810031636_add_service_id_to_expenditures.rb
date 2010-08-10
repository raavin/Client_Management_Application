class AddServiceIdToExpenditures < ActiveRecord::Migration
  def self.up
    add_column :expenditures, :service_id, :integer
  end

  def self.down
    remove_column :expenditures, :service_id
  end
end
