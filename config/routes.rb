# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  root to: 'home#index'

  resources :users, only: %w[show]
  resources :posts, only: %w[new create show edit update destroy]
  resources :comments, only: %w[create destroy new]

  patch '/likes/:id', to: 'likes#update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
