Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
    post '/upvote', to: 'votes#upvote'
    post '/downvote', to: 'votes#downvote'
  end
  resources :comments, except: [:new, :index] do
    post '/upvote', to: 'votes#upvote'
    post '/downvote', to: 'votes#downvote'
  end
end
