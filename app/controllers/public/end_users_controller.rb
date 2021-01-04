class Public::EndUsersController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit]

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
     redirect_to end_users_my_page_path(@customer.id)
    else
     render 'public/end_users/edit'
    end
  end

  def hidden
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end

end
