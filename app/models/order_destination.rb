class OrderDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zipcode, :area_id, :city, :address, :building, :phone, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :zipcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :city
    validates :address
    validates :phone, format: {with: /\A\d{10,11}\z/ }
    validates :token
  end
  validates :area_id, numericality: { other_than: 1 } 

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(zipcode: zipcode, area_id: area_id, city: city, address: address, building: building, phone: phone, order_id: order.id)
  end
end