# frozen_string_literal: true

Rails.application.routes.draw do
  resources :todos do
    member do
      patch 'move'
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'todos#index'
end
