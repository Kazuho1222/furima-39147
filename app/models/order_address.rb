class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :state_id, :city, :address, :building_name, :telephone_number, :order_id, :image

  with_options presence: true do
    validates :user_id, :item_id, :state_id, :city, :address, :order_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数値で入力してください"}
  end

  validates :state_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, state_id: state_id, city: city, address: address, building_name: building_name, telephone_number: telephone_number, order: order)
  end
end

