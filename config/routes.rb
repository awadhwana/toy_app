Rails.application.routes.draw do
  root 'home#home'
  get '/signup', to: 'users#new'
  get  '/help', to: 'home#help'
  get  '/about', to: 'home#about'
  get  '/contact', to: 'home#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
