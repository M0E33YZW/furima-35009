require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての値が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'hoge12'
        @user.password_confirmation = 'hoge12'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに@がない場合は登録できない' do
        @user.email = 'aaaaaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end
      it 'ユーザー本名の名字が空では登録できない' do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（全角）を入力してください")
      end
      it 'ユーザー本名の名字は全角の漢字・ひらがな・カタカナ以外登録できない' do
        @user.lastname = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字（全角）は不正な値です')
      end
      it 'ユーザー本名の名前が空では登録できない' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（全角）を入力してください")
      end
      it 'ユーザー本名の名前は全角の漢字・ひらがな・カタカナ以外登録できない' do
        @user.firstname = 'ｱｲｳｴｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（全角）は不正な値です')
      end
      it 'ユーザー本名の名字フリガナが空では登録できない' do
        @user.lastkana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ミョウジ（全角カナ）を入力してください")
      end
      it 'ユーザー本名の名字フリガナは全角カタカナ以外登録できない' do
        @user.lastkana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('ミョウジ（全角カナ）は不正な値です')
      end
      it 'ユーザー本名の名前フリガナが空では登録できない' do
        @user.firstkana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ナマエ（全角カナ）を入力してください")
      end
      it 'ユーザー本名の名前フリガナは全角カタカナ以外登録できない' do
        @user.firstkana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('ナマエ（全角カナ）は不正な値です')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
