Rails.application.routes.draw do
  resources :open_source_projects, only: %i[index new create]
  resources :issues, only: [:index]

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
      post :toggle_featured
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
    collection do
      get :export
    end
    resources :open_source_projects do
      resources :issues
    end
    resources :issues do
      collection do
        get 'fetch_github_issues'
      end
    end
  end

  get 'home/show'
  root 'home#show'
end
