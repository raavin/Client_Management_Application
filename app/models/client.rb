class Client < ActiveRecord::Base
  belongs_to :country
  has_many :case_notes
  has_many :expenditures
  has_many :waiting_lists
  has_and_belongs_to_many :services
end
