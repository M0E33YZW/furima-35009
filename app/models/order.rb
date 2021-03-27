class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one    :destination
  
  with_options presence: true, foreign_key: true do
    validates :user
    validates :item
end
