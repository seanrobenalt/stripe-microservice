Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users

  namespace :api, defaults: { format: :json } do
    match '/payments', to: 'payments#preflight', via: [:options]
    resources :payments, only: [:create]

    match '/customers', to: 'customers#preflight', via: [:options]
    resources :customers, only: [:create]

    match '/coupons', to: 'coupons#preflight', via: [:options]
    resources :coupons, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
