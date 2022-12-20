Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :categories, except: [:show] do
    resources :deals, except: [:show]
  end
  devise_for :users
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end


  authenticated :user do
    root "categories#index", as: :authenticated_root
  end

  root "users#index"
end
