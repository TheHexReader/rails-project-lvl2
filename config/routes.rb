# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    # get 'sign_out', to: 'devise/sessions#destroy'
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
