# frozen_string_literal: true

require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.has_role?(:admin) } do
    mount Sidekiq::Web, at: '/sidekiq', as: 'sidekiq'
  end

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cryptos
  resources :scores, only: %i[index create]
  root 'application#home'
end
