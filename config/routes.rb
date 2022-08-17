# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  # devise_scope :users do
  #   get 'sign_in', to: 'devise/sessions#new'
  #   get 'sign_up', to: 'devise/registrations#new'
  #   # get 'sign_out', to: 'devise/sessions#destroy'
  # end

  root to: 'home#index'

  resources :users, only: %w[show]
  resources :posts, only: %w[new create show edit update destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
