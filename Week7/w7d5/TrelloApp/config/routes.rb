Rails.application.routes.draw do
  resources :users
  resource :session
  root to: "static_pages#index"

  namespace :api, defaults: {format: 'json'} do
    resources :boards, only: [:index, :create, :show, :destroy]
    resources :lists, only: [:index]
    resources :cards, only: [:index]
  end
end
