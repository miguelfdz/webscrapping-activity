Rails.application.routes.draw do
  resources :search_product, only: [:new, :create], controller: :search_product
end
