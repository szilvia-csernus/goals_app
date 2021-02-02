Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:create, :destroy, :new]
  resources :users do
    resources :goals, only: [:index, :new, :create]
    resources :comments, only: :create
  end

  resources :goals, only: [:edit, :update, :destroy]

  resources :goals, only: :show do
    resources :comments, only: :create
    resources :cheers, only: :new
    member do 
      get :flip_progress
    end
  end

  root to: "users#index"
end
