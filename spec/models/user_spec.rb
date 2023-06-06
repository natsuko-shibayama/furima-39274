require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、first_name、last_name、first_name_kana、last_name_kana、date_of_birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nicknameを入力してください")
      end
      it 'nicknameが41字以上では登録できない' do
        @user.nickname = 'a' * 41 
        @user.valid?
        expect(@user.errors.full_messages).to include('Nicknameは40文字以内で入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'password'
        @user.password_confirmation = 'password'
        @user.valid?
        expect(@user.errors[:password]).to include('は半角英数字混合で入力してください')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include('は半角英数字混合で入力してください')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード123'
        @user.password_confirmation = 'パスワード123'
        @user.valid?
        expect(@user.errors[:password]).to include('は半角英数字混合で入力してください')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include('はすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'お名前(全角)の名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last nameを入力してください")
      end

      it 'お名前(全角)の名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameを入力してください")
      end

      it 'お名前(全角)が全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last nameが無効です')
      end

      it 'お名前(全角)が全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('First nameが無効です')
      end

      it 'お名前カナ(全角)の名字が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanaを入力してください")
      end

      it 'お名前カナ(全角)の名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaを入力してください")
      end

      it 'お名前カナ(全角)が全角（カタカナ）でなければ登録できない' do
        @user.last_name_kana = 'すみす' # 全角カタカナ以外の文字を設定
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanaが無効です')
      end

      it 'お名前カナ(全角)が全角（カタカナ）でなければ登録できない' do
        @user.first_name_kana = 'すみす' # 全角カタカナ以外の文字を設定
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanaが無効です')
      end

      it '生年月日が空では登録できない' do
        @user.date_of_birth = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birthを入力してください")
      end
    end
  end
end
