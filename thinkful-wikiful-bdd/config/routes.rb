Rails.application.routes.draw do 
  get   'articles/autocomplete_authors',      
                                to: 'articles#autocomplete_authors',
                                                        as: :articles_autocomplete_authors

  get   'articles/search',      to: 'articles#search',  as: :articles_search
  post  'articles/search',      to: 'articles#search'

  resources :articles
  
  post  'articles/author(/:author)',  to: 'articles#author', as: :articles_author
  post  'articles/date(/:date)',      to: 'articles#date',   as: :articles_date

  get   'login',  to: 'sessions#new',     as: :login
  post  'login',  to: 'sessions#create'

  get   'logout', to: 'sessions#destroy', as: :logout

  get   'signup', to: 'users#new',        as: :signup
  post  'signup', to: 'users#create'

  root to: 'home#index'
end