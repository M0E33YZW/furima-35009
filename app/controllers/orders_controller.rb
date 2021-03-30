class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, only: [:create, :update]
  before_action :set_items, only: [:index, :create]

  def index
    @order_destination = OrderDestination.new
  end

  def new
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end
end
