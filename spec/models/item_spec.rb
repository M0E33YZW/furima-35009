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
        @item.price = 300
        @item.valid?
        expect(@item).to be_valid
      end
      it '販売価格が¥9999999だと登録できる' do
        @item.price = 9_999_999
        @item.valid?
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it '商品画像がない場合は登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end
      it '商品名がない場合は登録できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品説明がない場合は登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it '商品のカテゴリー選択がない場合は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end
      it '商品の状態の選択がない場合は登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は1以外の値にしてください')
      end
      it '配送料の負担の選択がない場合は登録できない' do
        @item.shipping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
      end
      it '発送元の地域の選択がない場合は登録できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
      end
      it '発送までの日数の選択がない場合は登録できない' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
      end
      it '販売価格がない場合は登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it '販売価格が299以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end
      it '販売価格が10000000だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は9999999以下の値にしてください')
      end
      it '販売価格が全角だと登録できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格が半角英数字混合では登録できない' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格は半角英語では登録できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
    end
  end
end
