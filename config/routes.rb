# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'todos#index'

  resources :todos, except: [:show]

  constraints ->(req) { req.format == :json } do
    resources :todos, only: [:show]
  end
end
