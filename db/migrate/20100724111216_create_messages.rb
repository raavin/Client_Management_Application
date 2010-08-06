class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.references :user
      t.references :service
      t.string :subject
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
