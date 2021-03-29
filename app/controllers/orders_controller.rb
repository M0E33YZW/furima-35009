class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_items, only: [:index, :create]

  def index
    @order_destination = OrderDestination.new
  end

  def new
    @order_destination = OrderDestination.new(order_params)
  end
  
  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:zipcode, :area_id, :city, :address, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_items
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_ca11b9c954bdc0281f3aa7ea"
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
