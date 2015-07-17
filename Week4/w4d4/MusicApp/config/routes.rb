Rails.application.routes.draw do

  resource :user, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end
  resources :tracks, except: [:index] do
    resources :notes, only: [:create, :destroy]
  end
  resources :notes, only: [:destroy]
  
end
