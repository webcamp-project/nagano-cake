class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:send_address].to_i == 0
        @order.name = current_customer.full_name
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
    elsif params[:order][:send_address].to_i == 1
        @address = Address.find(params[:order][:address_id])
        @order.name = @address.name
        @order.postal_code = @address.postal_code
        @order.address = @address.address
    elsif params[:order][:send_address].to_i == 2
        @address = Address.new
        @address.name = params[:order][:name]
        @address.postal_code = params[:order][:postal_code]
        @address.address = params[:order][:address]
        if @address.save
        @order.name = @address.name
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        else
        render :new
        end
    end
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.product_total = cart_item.item.add_tax_price
      @order_detail.order_id = @order.id
      @order_detail.save
    end

  current_customer.order_details.destroy_all
  redirect_to order_complete_path

  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :name, :address, :total_price, :postage)
  end

end