Rails.application.routes.draw do
  get 'issues/index'
  get 'issues/new'
  get 'issues/edit'
  get 'contributions/create'
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
  resources :companies do
    get 'search', on: :collection
    member do
      patch :update_status
    end
    resources :contributions, only: [:create]
    resources :issues, except: [:show]
  end

  get 'home/show'
  root 'home#show'
end
