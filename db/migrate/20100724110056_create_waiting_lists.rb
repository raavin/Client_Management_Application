class CreateWaitingLists < ActiveRecord::Migration
  def self.up
    create_table :waiting_lists do |t|
      t.references :client
      t.references :service
      t.references :category
      t.timestamp :referral_date
      t.timestamp :accepted_date
      t.timestamp :completed_date

      t.timestamps
    end
  end

  def self.down
    drop_table :waiting_lists
  end
end
