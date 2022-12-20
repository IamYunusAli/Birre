Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :categories, except: [:show] do
    resources :deals, except: [:show]
  end
  devise_for :users

  authenticated :user do
    root "categories#index", as: :groups_path
  end
  root "users#index"
end
