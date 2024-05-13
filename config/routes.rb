Rails.application.routes.draw do
  resources :blogs do
    member do
      patch :update_status
    end
  end

  draw :madmin
  # resources :category_companies, only: [:create, :destroy]

  resources :categories do
    resources :companies, only: [:create], controller: 'category_companies'
    member do
      delete 'remove_company/:company_id', to: 'categories#remove_company', as: :remove_company
    end
  end

  devise_for :users
  resources :users
  resources :companies

  get 'home/show'
  root "home#show"
end
