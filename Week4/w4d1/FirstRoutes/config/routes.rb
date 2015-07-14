Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update, :destroy] do
    resources :groups, only: [:index, :show, :create, :update, :destroy] do
      resources :contacts, only: :index
    end
    resources :comments, only: [:index, :create, :show, :update, :destroy]
    get 'favorite_contacts', on: :member
  end

  resources :contacts, only: [:create, :show, :update, :destroy] do
    resources :comments, only: [:index, :create, :show, :update, :destroy]
  end

  resources :contact_shares, only: [:create, :destroy]
  resources :groupings, only: [:create, :destroy]
end
