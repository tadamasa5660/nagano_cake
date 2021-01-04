class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :edit]

  def index
     @customers = Customer.order(id: "DESC").page(params[:page]).reverse_order.per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     redirect_to admin_end_user_path(@customer.id)
    else
     render 'admin/end_users/edit'
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active, :created_at, :updated_at)
  end

end
