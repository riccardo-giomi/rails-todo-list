# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'todos#index'

  resources :todos, except: [:show]
  namespace :todos do
    get '/cancel_create', to: '/todos#cancel_create'
  end

  constraints ->(req) { req.format == :json } do
    resources :todos, only: [:show]
  end
end
