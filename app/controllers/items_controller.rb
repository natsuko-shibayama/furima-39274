class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]

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


  private

  def item_params
    params.require(:item).permit(:content, :image, :name, :category_name_id, :condition_id, :shipping_fee_payer_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end