Rails.application.routes.draw do
  resources :apps, :except => [:edit, :update]

  root 'welcome#index'

  devise_for :users

  namespace :api, defaults: { format: :json } do
    match '/payments', to: 'payments#preflight', via: [:options]
    resources :payments, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
