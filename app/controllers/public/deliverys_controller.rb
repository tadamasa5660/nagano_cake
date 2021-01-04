class Public::DeliverysController < ApplicationController
  before_action :authenticate_customer!, only: [:index, :edit]

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
     redirect_to deliverys_path
    else
     @addresses = Address.all
     render 'public/deliverys/index'
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
     redirect_to deliverys_path
    else
     render 'public/deliverys/edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to deliverys_path
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address, :created_at, :updated_at)
  end

end
