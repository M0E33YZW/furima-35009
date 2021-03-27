class OrdersController < ApplicationController
  def index
  end

  def create
    @order = Order.new(order_params)
    binding.pry
    if @order.valid?
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end
end
