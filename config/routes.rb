# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  root to: 'home#index'

  resources :users, only: %w[show]
  resources :posts, only: %w[new create show edit update destroy]
  resources :comments, only: %w[create destroy new]

  patch '/likes/:id', to: 'likes#update', as: 'post_like'
end
