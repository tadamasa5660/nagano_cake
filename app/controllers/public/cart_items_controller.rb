class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:index]

  def index
    @cart_item = current_customer.cart_items
    @sum = 0
    @cart_item.each do |cart_item|
     @sum = @sum + cart_item.item.price*cart_item.amount*1.1
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
     redirect_to cart_items_path
    else
     render 'public/cart_items/index'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
     redirect_to cart_items_path(@cart_item.id)
    else
     @genre = Genre.all
     @item = Item.find(params[:id])
     render 'public/items/show'
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
