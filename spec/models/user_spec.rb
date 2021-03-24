require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it '全ての値が存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it "nicknameが空では登録できない" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空では登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it "emailに@がない場合は登録できないこと " do
      @user.email = 'aaaaaa.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "passwordが空では登録できないこと" do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが6文字以上であれば登録できること' do
      @user.password = 'hoge123'
      @user.password_confirmation = 'hoge123'
      expect(@user).to be_valid
    end
    it "passwordは半角英数字混合でないと登録できないこと" do
      @user.password = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "ユーザー本名の名字が空では登録できないこと" do
      @user.lastname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname can't be blank","Lastname is invalid")
    end
    it "ユーザー本名は全角の漢字・ひらがな・カタカナ以外登録できない" do
      @user.lastkana = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastkana is invalid")
    end
    it "ユーザー本名の名前が空では登録できない" do
      @user.firstname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname can't be blank","Firstname is invalid")
    end
    it "ユーザー本名は名前は全角の漢字・ひらがな・カタカナ以外登録できない" do
      @user.firstname = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname is invalid")
    end
    it "ユーザー本名の苗字フリガナが空では登録できない" do
      @user.lastkana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastkana can't be blank","Lastkana is invalid")
    end
    it "ユーザー本名の苗字フリガナは全角カタカナ以外入力できない" do
      @user.lastkana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastkana is invalid")
    end
    it "ユーザー本名の名前フリガナが空では登録できない" do
      @user.firstkana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstkana can't be blank","Firstkana is invalid")
    end
    it "ユーザー本名の名前フリガナは全角カタカナ以外入力できない" do
      @user.firstkana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstkana is invalid")
    end
    it "生年月日が空では登録できないこと" do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end