class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_name, class_name: 'Category'
  belongs_to :condition
  belongs_to :shipping_fee_payer
  belongs_to :prefecture
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image
end
