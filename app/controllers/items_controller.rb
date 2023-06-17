class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order('created_at DESC')
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
      redirect_to action: :index
    end
  end

  def update
    if current_user == @item.user
      if @item.update(item_params)
        redirect_to item_path
      else
        render :edit
      end
    else
      redirect_to action: :index
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :state_id, :shipping_date_id,
                                 :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
