Rails.application.routes.draw do
  root "events#index"
  
  devise_for :users

  resources :events do
    resources :pictures, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
    post :show, on: :member
  end
  resources :users, only: %i[show]
end
