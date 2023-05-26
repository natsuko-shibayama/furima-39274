class ItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def new
    @item = Item.new
  end
end



  private

  def item_params
    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
  end