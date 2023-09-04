Rails.application.routes.draw do
  # resources :category_companies, only: [:create, :destroy]
  
  resources :categories do
    resources :companies, only: [:create], controller: 'category_companies'
  end
  


  devise_for :users
  resources :users

  resources :companies

  get 'home/show'
  
  root "home#show"
end
