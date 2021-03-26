require 'rails_helper'

RSpec.describe Item, type: :item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '表品が出品できる場合' do
      it '画像と必要な情報の適切な入力があれば保存される' do
        expect(@item).to be_valid
      end
      it '販売価格が¥300だと登録できる' do
        @item.price = '300'
        @item.valid?
        expect(@item).to be_valid
      end
      it '販売価格が¥9999999だと登録できる' do
        @item.price = '9999999'
        @item.valid?
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it '商品画像がない場合は登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がない場合は登録できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it '商品説明がない場合は登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品のカテゴリー選択がない場合は登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '配送料の負担の選択がない場合は登録できない' do
        @item.shipping_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping can't be blank")
      end
      it '発送元の地域の選択がない場合は登録できない' do
        @item.area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it '発送までの日数の選択がない場合は登録できない' do
        @item.day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank")
      end
      it '販売価格がない場合は登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が299以下だと登録できないこと' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '販売価格が10000000だと登録できないこと' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '販売価格は全角だと登録できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
