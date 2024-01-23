# Below are the routes for madmin
namespace :madmin do
  resources :blogs
  namespace :action_text do
    resources :rich_texts
  end
  resources :companies
  resources :users
  resources :categorizations
  resources :categories
  root to: "dashboard#show"
end
