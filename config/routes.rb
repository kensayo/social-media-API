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
end
