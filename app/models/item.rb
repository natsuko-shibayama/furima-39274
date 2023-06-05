class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :category_name, class_name: "Category", foreign_key: "category_name_id"
  belongs_to :shipping_fee_payer
  belongs_to :prefecture
  belongs_to :shipping_day
  belongs_to :condition
  belongs_to :user
  has_one_attached :image
  has_one :order
  validates :content, presence: true, unless: :was_attached?
  validates :name, :content, :price, :image, presence: true
  validates :price, numericality:{only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :category_name_id, :condition_id, :shipping_fee_payer_id, :prefecture_id, :shipping_day_id, 
  numericality: { other_than: 1, message: "can't be blank"}

  def was_attached?
    self.image.attached?
  end
end