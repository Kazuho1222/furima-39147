class Item < ApplicationRecord
  belongs_to :user
  # has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :state
  belongs_to :shipping_date

  validates :name, :description, :category_id, :status_id, :postage_id, :state_id, :shipping_date_id, :price, :user, :image,
            presence: true
  validates :category_id, :status_id, :postage_id, :state_id, :shipping_date_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
end
