# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :tranxactions, path: :transactions

  get 'tax_summaries' => 'pages#tax_summaries'

  root 'pages#home'
end
