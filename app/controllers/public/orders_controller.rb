class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:index, :new, :show, :confirm, :complete]

  def new
    @order = Order.new
    @address = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    case params[:order][:address_status]
     when "自身の住所"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      when "登録住所"
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      when "入力住所"
        # session[:order][0] = params[:order][:postal_code]
        # session[:order][1] = params[:order][:address]
        # session[:order][2] = params[:order][:name]
    end
    @cart_item = current_customer.cart_items
    @shipping_cost = 800
    @sum = 0
    @cart_item.each do |cart_item|
     @sum = @sum + cart_item.item.price*cart_item.amount*1.1
    end
    @total_payment = @shipping_cost + @sum
  end

  def create
    # @order.payment_method = session[:payment_method]
    # @order.postal_code = session[:order][0]
    # @order.address = session[:order][1]
    # @order.name = session[:order][2]
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = 800
    @cart_item = current_customer.cart_items
    @cart_item.each do |cart_item|
     @order.total_payment += cart_item.item.price*cart_item.amount*1.1
    end
    if @order.save
       @cart_item.each do |cart_item|
        order_detail = @order.order_details.new
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price
        order_detail.making_status = 0
        order_detail.save
        cart_item.destroy
       end
     redirect_to complete_orders_path
    else
     render 'public/orders/comfir'
    end

  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    # @order_details = OrderDetail.where(order_id: @orders.ids)
  end

  def show
    @order = Order.find(params[:id])
    @order_price = @order.total_payment - @order.shipping_cost
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name , :payment_method)
  end

end
