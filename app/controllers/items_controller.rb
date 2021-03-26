class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  before_action :set_items, only: [:show, :edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
    @item = Item.new
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless current_user == @item.user
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :status_id, :shipping_id, :area_id, :day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
