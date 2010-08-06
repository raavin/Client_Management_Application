class Category < ActiveRecord::Base
  belongs_to :service
  has_many :waiting_lists
end
