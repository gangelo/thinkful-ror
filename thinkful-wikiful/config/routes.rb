Rails.application.routes.draw do
  resources :sessions

  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create' #, as: 'signup'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'categories/index'
	get 'categories/show'

  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :articles, :categories
end
