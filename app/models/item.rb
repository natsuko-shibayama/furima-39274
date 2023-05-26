class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_name, class_name: 'Category'
  belongs_to :condition
  belongs_to :shipping_fee_payer
  belongs_to :prefecture
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :content, presence: true
  validates :category_name_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_fee_payer_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_day_id, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A\d+\z/, message: "半角数値のみ入力してください" }
end
