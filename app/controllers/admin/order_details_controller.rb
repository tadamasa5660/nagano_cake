class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find_by(id: @order_detail.order_id)
    @order_details = OrderDetail.where(order_id: @order.id)
    if @order_detail.update(order_detail_params)
      if @order_details.where(making_status: "製作中").any?
          @order.update(status: "製作中")
      elsif @order_details.pluck(:making_status).all?("製作完了")
          @order.update(status: "発送準備中")
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