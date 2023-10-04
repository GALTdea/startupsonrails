# Below are the routes for madmin
namespace :madmin do
  resources :companies
  resources :users
  resources :categorizations
  resources :categories
  root to: "dashboard#show"
end
