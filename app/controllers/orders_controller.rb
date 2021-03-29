class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
  end

  def new
    @order_destination = OrderDestination.new
  end
  
  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(zipcode: zipcode, area_id: area_id, city: city, address: address, building: building, phone: phone).merge(user_id: current_user.id, item_id: item_id)
  end

  #def set_items
    #@item = Item.find(params[:id])
  #end
end
