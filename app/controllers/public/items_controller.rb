class Public::ItemsController < ApplicationController

  def index
    @genre = Genre.all
    if params[:genre_id].present?
     @item = Item.where(genre_id: params[:genre_id]).where(is_active: true).order(id: "DESC").page(params[:page]).per(8)
     @items = Item.where(genre_id: params[:genre_id]).where(is_active: true)
    else
     @item = Item.where(is_active: true).order(id: "DESC").page(params[:page]).per(8)
     @items = Item.where(is_active: true)
    end
  end

  def show
    @genre = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :image_id, :introduction, :price, :is_active, :created_at, :updated_at)
  end
end
