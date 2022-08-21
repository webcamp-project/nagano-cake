class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    params[:order][:receive_status] = params[:order][:receive_status].to_i
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
    redirect_to admin_order_path(@order.id)
    else
    render :show
    end

    if @order.receive_status == "入金確認"
      @order_details.update_all(making_status:1)
    end
  end

  private

  def order_params
    params.require(:order).permit(:receive_status)
  end
end
