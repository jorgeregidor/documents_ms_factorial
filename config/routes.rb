# frozen_string_literal: true

Rails.application.routes.draw do
  resources :snippets

  resources :documents do
    resources :permissions
  end

  get '/health', to: 'ms_service#show'
  match '*path', to: 'ms_service#error_404', via: :all
  root           to: 'ms_service#error_404'
end
