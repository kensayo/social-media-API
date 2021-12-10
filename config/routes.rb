# frozen_string_literal: true
Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :users, only: %i[index show] do
    post 'add-friend', to: 'friendship#create'
    get 'friend-request', to: 'friendship#index'
    put 'accept', to: 'friendship#accept'
    put 'reject', to: 'friendship#reject'
  end
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end

  namespace :api do
    namespace :v1, default: { format: :json }  do
      resources :posts, only: %i[index create] do
        resources :comments, only: %i[index]
        post '/new', to: 'comment#create', as: 'new_comment'
      end
      devise_scope :user do
        post '/sign_in', to: 'session#create'
        post '/sign_up', to: 'registration#create'
        delete '/sign_out', to: 'session#destroy'
      end
    end
  end

end



