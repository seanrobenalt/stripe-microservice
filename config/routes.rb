Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'welcome#index'

  devise_for :users

  namespace :api, defaults: { format: :json } do
    match '/payments', to: 'application#preflight', via: [:options]
    resources :payments, only: [:create]

    match '/customers', to: 'application#preflight', via: [:options]
    resources :customers, only: [:create]

    match '/coupons', to: 'application#preflight', via: [:options]
    resources :coupons, only: [:create]

    match '/plans', to: 'application#preflight', via: [:options]
    resources :plans, only: [:create]

    match '/accounts', to: 'application#preflight', via: [:options]
    resources :accounts, only: [:create]

    match '/bank_accounts', to: 'application#preflight', via: [:options]
    resources :bank_accounts, only: [:create]

    match '/subscriptions', to: 'application#preflight', via: [:options]
    resources :subscriptions, only: [:create]

    match '/refunds', to: 'application#preflight', via: [:options]
    resources :refunds, only: [:create]

    match '/payouts', to: 'application#preflight', via: [:options]
    resources :payouts, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
