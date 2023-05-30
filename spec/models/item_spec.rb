require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品が正しく行われる場合' do
      it '全ての情報が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品が正しく行われない場合' do
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      
      it '商品画像が添付されていなければ登録されない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空の場合登録されない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空の場合登録されない' do
        @item.content = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end

      it 'カテゴリーが空の場合登録されない' do
        @item.category_name_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category name can't be blank")
      end

      it 'カテゴリーに「---」が選択されている場合登録されない' do
        @item.category_name_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category name can't be blank")
      end

      it '商品の状態が空の場合登録されない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '商品の状態に「---」が選択されている場合登録されない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '配送料の負担が空の場合登録されない' do
        @item.shipping_fee_payer_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee payer can't be blank")
      end

      it '配送料の負担に「---」が選択されている場合登録されない' do
        @item.shipping_fee_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee payer can't be blank")
      end

      it '発送元が空の場合登録されない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域に「---」が選択されている場合登録されない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が空の場合登録されない' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it '発送までの日数に「---」が選択されている場合登録されない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it '価格が空の場合登録されない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格は半角数値で入力されていない場合登録できない' do
        @item.price = "２０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が300円以下の場合登録されない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '価格が9999999円以上の場合登録されない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end
