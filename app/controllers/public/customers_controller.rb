class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def confirm
    @customer = current_customer
  end

  def update_status
    @customer = current_customer
    @customer.update(is_delete: true)
    reset_session
    flash[:notice] = "退会が完了しました。"
    redirect_to root_path
  end

  private

  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_delete)
  end
end
