# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'todos#index'

  resources :todos, except: [:show]

  # We have no "show" page, so we only respond to these requests in JSON:
  get 'todos/:id', to: 'todos#show', constraints: ->(req) { req.format = :json }
end
