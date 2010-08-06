class WaitingList < ActiveRecord::Base
  belongs_to :client
  belongs_to :service
  belongs_to :category
  has_many :waiting_lists
end
