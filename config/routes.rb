Rails.application.routes.draw do
  get 'apps/index'

  get 'apps/new'

  get 'apps/show'

  get 'apps/edit'

  get 'apps/update'

  get 'apps/destroy'

  root 'welcome#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
