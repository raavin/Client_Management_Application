class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :service_name
      t.text :description
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
