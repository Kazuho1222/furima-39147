require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '必要事項を全て過不足なく入力すると購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物名以外、必要事項を全て過不足なく入力すると購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'post_codeが空では購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'state_idが空では購入できない' do
        @order_address.state_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("State can't be blank")
      end
      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'telephone_numberが12桁以上では購入できない' do
        @order_address.telephone_number = '090123456489'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Telephone number は10桁以上11桁以内の半角数値で入力してください')
      end
      it 'telephone_numberが全角文字を含むと購入できない' do
        @order_address.telephone_number = 'ａａa １１1漢字'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Telephone number は10桁以上11桁以内の半角数値で入力してください')
      end
      it 'telephone_numberが9桁以下では購入できない' do
        @order_address.telephone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Telephone number は10桁以上11桁以内の半角数値で入力してください')
      end
      it 'telephone_numberが空では購入できない' do
        @order_address.telephone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'post_codeが全角文字を含むと購入できない' do
        @order_address.post_code = 'ａａa １１1漢字'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'post_codeが「3桁ハイフン4桁」の半角文字列以外だと購入できない' do
        @order_address.post_code = '00000000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '発送元の地域に「---」が選択されている場合は購入できない' do
        @order_address.state_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("State can't be blank")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_address = FactoryBot.build(:order_address, user_id: nil)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_address = FactoryBot.build(:order_address, item_id: nil)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では購入できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
