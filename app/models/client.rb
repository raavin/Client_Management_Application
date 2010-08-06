class Client < ActiveRecord::Base
  belongs_to :country
  has_many :case_notes
  has_many :expenditures
  belongs_to :client
end
