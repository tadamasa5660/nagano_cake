class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show]

  def index
    @orders = Order.page(params[:page]).reverse_order.per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @shipping_cost = 800
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    if @order.update(order_params)
      if @order.status = "入金確認"
        @order_details.update(making_status: "製作待ち")
      end
     redirect_to admin_order_path(@order.id)
    else
     render 'admin/orders/show'
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)

  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
