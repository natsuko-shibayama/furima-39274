require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  describe '購入機能' do
    context '商品購入が正しく行われる場合' do
      it '全ての情報が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end
    end

    context '商品の購入が正しく行われない場合' do
      it 'userが紐付いていなければ購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が空の場合購入できない' do
        @order_form.postal_code = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it "無効な郵便番号の形式の場合購入できない" do
        @order_form.postal_code = "1234567"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:postal_code]).to include("is invalid. Include hyphen(-)")
      end

      it '都道府県が空の場合購入できない' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域に「---」が選択されている場合登録されない' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空の場合購入できない' do
        @order_form.city = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空の場合購入できない' do
        @order_form.street_address = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空の場合購入できない' do
        @order_form.phone_number = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it "無効な電話番号の形式の場合購入できない" do
        @order_form.phone_number = "090-1234-5678"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include("is invalid. Please enter numbers only")
      end
    end
  end
end