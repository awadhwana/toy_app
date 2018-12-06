Rails.application.routes.draw do
  root 'home#home'
  resources :users, except: :new
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get  '/help', to: 'home#help'
  get  '/about', to: 'home#about'
  get  '/contact', to: 'home#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
