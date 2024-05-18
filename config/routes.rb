Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root'items#index', as: 'home'
  delete 'clear_basket' => 'orders#clear_basket', as: 'clear_basket'
  resources :items
  resources :users
  resources :orders
  post 'create_order', to: 'orders#create_order'
  get 'allusers' => 'users#index', as: 'allusers'
  post 'add_to_basket', to: 'baskets#add_to_basket'
end
