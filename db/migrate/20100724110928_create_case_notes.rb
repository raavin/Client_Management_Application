class CreateCaseNotes < ActiveRecord::Migration
  def self.up
    create_table :case_notes do |t|
      t.references :user
      t.references :client
      t.references :service
      t.string :subject
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :case_notes
  end
end
