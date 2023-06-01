class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
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
    if current_user.id != @item.user_id
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

  def set_item
    @item = Item.find(params[:id])
    redirect_to root_path if current_user.id != @item.user_id
  end

  def item_params
    params.require(:item).permit(:content, :image, :name, :category_name_id, :condition_id, :shipping_fee_payer_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end