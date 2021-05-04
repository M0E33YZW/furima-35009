require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '商品の購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
      sleep 1
    end

    context '商品が購入できるとき' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@order_destination).to be_valid
      end
      it '建物名は空でも保存できる' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '商品の購入ができないとき' do
      it '郵便番号が空では購入できない' do
        @order_destination.zipcode = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_destination.zipcode = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '都道府県の選択がなければ購入できない' do
        @order_destination.area_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('都道府県は1以外の値にしてください')
      end
      it '市区町村が空では登録できない' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空では登録できない' do
        @order_destination.address = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では登録できない' do
        @order_destination.phone = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号が英数混合では登録できない' do
        @order_destination.phone = '0123456test'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が12桁以上では登録できない' do
        @order_destination.phone = '090123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'tokenが空では登録できない' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'user_idが空では登録できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空では登録できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
