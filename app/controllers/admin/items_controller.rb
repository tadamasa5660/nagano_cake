class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new, :show, :edit]

  def index
    @items = Item.order(id: "DESC").page(params[:page]).reverse_order.per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
     redirect_to admin_item_path(@item.id)
    else
     render 'admin/items/new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
     redirect_to admin_item_path(@item.id)
    else
     render 'admin/items/edit'
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active, :created_at, :updated_at)
  end

end
