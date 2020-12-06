# frozen_string_literal: true

require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web, at: '/sidekiq', as: 'sidekiq'
  end

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cryptos
  resources :scores, only: %i[index create]
  # API
  get 'minutes_to_sale', to: 'charts#minutes_to_sale'
  get 'total_scalped', to: 'charts#total_scalped'

  root 'application#home'
end
