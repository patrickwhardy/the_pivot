class Reservation < ActiveRecord::Base
  belongs_to :tool
  belongs_to :date_reserved
  belongs_to :user
end
