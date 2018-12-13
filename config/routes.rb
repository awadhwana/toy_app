Rails.application.routes.draw do
  get 'sessions/new'
  root 'home#home'
  resources :users, except: :new
  resources :account_activations, only: [:edit]
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  get      '/help', to: 'home#help'
  get     '/about', to: 'home#about'
  get   '/contact', to: 'home#contact'
  get     '/login', to: 'sessions#new'
  post    '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
