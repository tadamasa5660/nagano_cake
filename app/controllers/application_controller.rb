class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      case resource
      when Admin
         admin_orders_path
      when Customer
         end_users_my_page_path
      else
         super
      end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
      root_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
       new_customer_registration_path
    end
  end

  def authenticate_customer
   if @current_customer == nil
   redirect_to new_customer_session_path
   end
  end

  private
    def configure_permitted_parameters
     added_attrs = [ :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation, :is_active]
     devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
     devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

end
