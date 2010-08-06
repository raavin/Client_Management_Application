class CreateExpenditures < ActiveRecord::Migration
  def self.up
    create_table :expenditures do |t|
      t.references :client
      t.references :user
      t.string :description
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :expenditures
  end
end
