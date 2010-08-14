class Service < ActiveRecord::Base
  has_many :expenditures
  has_and_belongs_to_many :clients
end
