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
        expect(@order_destination.errors.full_messages).to include("Zipcode can't be blank")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_destination.zipcode = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Zipcode is invalid')
      end
      it '都道府県の選択がなければ購入できない' do
        @order_destination.area_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Area must be other than 1')
      end
      it '市区町村が空では登録できない' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end
      it '電話番号が空では登録できない' do
        @order_destination.phone = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone can't be blank")
      end
      it 'tokenが空では登録できない' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では登録できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
