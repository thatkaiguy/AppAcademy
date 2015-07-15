Rails.application.routes.draw do
  root 'cats#index'
  resources :cats
  resources :cat_rental_requests, except: [:index]

  get 'cat_rental_requests/:id/approve', to: 'cat_rental_requests#approve', as: "approve_request"
  get 'cat_rental_requests/:id/deny', to: 'cat_rental_requests#deny', as: "deny_request"
end
