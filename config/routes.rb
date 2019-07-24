# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Attachments
  get 'attachments/presigned' => 'attachments#presigned'
  resources :attachments
  resources :clients
  get 'entries/by_date' => 'entries#by_date'
  resources :entries, only: %i[update destroy]
  get 'payment_summaries/year_endings' => 'payment_summaries#year_endings'
  resources :payment_summaries
  resources :projects
  resources :properties, only: :index do
    resources :tenancy_agreements
  end
  resources :scores, only: %i[index create]
  resources :tax_categories, only: :index
  # Tenancy Agreements
  resources :tenancy_agreements, only: :index
  get 'tranxactions/balance' => 'tranxactions#balance'
  resources :tranxactions
  resources :tranxaction_types
  # Users
  get 'number_of_users' => 'users#return_number_of_users'
  resources :users, only: [:index]

  root 'application#index'

 # Need this for prettifying url
  get '/', to: redirect('/#!/')
end
