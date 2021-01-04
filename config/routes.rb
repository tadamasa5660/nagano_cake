Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions:      'admins/sessions'
  }
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  registrations: 'customers/registrations'
  }

  namespace :admin do
    root   'homes#top'
    resources :items, only: [:index ,:new ,:create, :show ,:edit ,:update]
    resources :genres, only: [:index ,:create, :edit ,:update]
    resources :end_users, only: [:index ,:show ,:edit ,:update]
    resources :orders, only: [:index , :show ,:update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root 'homes#top'
    get    'about'                  => 'homes#about'
    resources :items, only: [:index ,:show]
    get    '/end_users/my_page'     => 'end_users#show'
    get    '/end_users/edit'        => 'end_users#edit'
    patch  '/end_users'             => 'end_users#update'
    get    '/end_users/hide'        => 'end_users#hide'
    patch  '/end_users/hidden'      => 'end_users#hidden'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index ,:update ,:destroy ,:create]
    resources :orders do
     collection do
       post   'confirm'
       get    'complete'
     end
    end
    resources :orders, only: [:new ,:create , :index , :show]
    resources :deliverys, only: [:index ,:edit ,:create, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
