class Order < ApplicationRecord
  with_options presence: true, foreign_key: true do
    validates :user
    validates :item
end
