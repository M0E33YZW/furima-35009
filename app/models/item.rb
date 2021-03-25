class Item < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping
  belongs_to :area
  belongs_to :day

  with_options presence: true do
    validates :title
    validates :description
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :status_id
      validates :shipping_id
      validates :area_id
      validates :day_id
    end
  end
end