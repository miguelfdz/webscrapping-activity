Rails.application.routes.draw do
  resources :search_product, only: [:new, :create, :show], controller: :search_product

  root 'search_product#new'
end
