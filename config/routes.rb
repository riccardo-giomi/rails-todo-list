# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'todos#index'

  resources :todos, except: [:show]

  namespace :todos do
    get '/cancel_create',   to: '/todos#cancel_create'
    get '/:id/cancel_edit', to: '/todos#cancel_edit', as: 'cancel_edit'
    patch '/:id/move', to: '/todos#move', as: 'move'
  end

  constraints ->(req) { %i[json turbo_stream].include? req.format.to_sym } do
    resources :todos, only: [:show]
  end
end
