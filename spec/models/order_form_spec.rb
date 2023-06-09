require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  describe '購入機能' do
    context '商品購入が正しく行われる場合' do
      it '全ての情報が正しく入力されてtokenがあれば購入できる' do
        expect(@order_form).to be_valid
      end

      it '建物が空の場合でも購入できる' do
        @order_form.building_name = ""
        expect(@order_form).to be_valid
      end

    end

    context '商品の購入が正しく行われない場合' do
      it 'userが紐付いていなければ購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていなければ購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Itemを入力してください")
      end

      it "tokenが空では登録できないこと" do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("カード情報を入力してください")
      end

      it '郵便番号が空の場合購入できない' do
        @order_form.postal_code = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("郵便番号を入力してください")
      end

      it "無効な郵便番号の形式の場合購入できない" do
        @order_form.postal_code = "1234567"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:postal_code]).to include(" は無効です。 ハイフン(-)を含めて入力してください。")
      end

      it '都道府県が空の場合購入できない' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("都道府県を入力してください")
      end

      it '都道府県に「---」が選択されている場合登録されない' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("都道府県を選択してください")
      end

      it '市区町村が空の場合購入できない' do
        @order_form.city = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地が空の場合購入できない' do
        @order_form.street_address = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号が空の場合購入できない' do
        @order_form.phone_number = ""
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号を入力してください")
      end

      it "無効な電話番号の形式の場合購入できない" do
        @order_form.phone_number = "090-1234-5678"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include("は無効です。数字のみ入力してください")
      end

      it "電話番号が数字でなければ購入できない" do
        @order_form.phone_number = "test"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include("は無効です。数字のみ入力してください")
      end

      it "電話番号が9桁の場合は購入できない" do
        @order_form.phone_number = "123456789"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include("は無効です。数字のみ入力してください")
      end

      it "電話番号が12桁の場合は購入できない" do
        @order_form.phone_number = "123456789012"
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include("は無効です。数字のみ入力してください")
      end

    end
  end
end