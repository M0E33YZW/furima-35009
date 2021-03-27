class Destination < ApplicationRecord
  belongs_to :order

  with_options presence: true do
    validates :order ,foreign_key: true
    validates :zipcode
    validates :area_id
    validates :city
    validates :address
    validates :phone
end
