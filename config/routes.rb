# frozen_string_literal: true

Rails.application.routes.draw do
  admin_devise_config = ActiveAdmin::Devise.config
  admin_devise_config[:controllers][:sessions] = 'active_admin/sessions'
  devise_for :users, admin_devise_config
  ActiveAdmin.routes(self)

  resources :cryptos
  resources :scores, only: %i[index create]
  # API

  root 'application#home'
end
