Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :companies

  get 'home/show'
  
  root "home#show"
end
