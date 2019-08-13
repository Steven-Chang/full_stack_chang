# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Attachments
  get 'attachments/presigned' => 'attachments#presigned'
  resources :attachments, except: %i[new show]
  get 'entries/by_date' => 'entries#by_date'
  resources :entries, only: %i[update destroy]
  resources :scores, only: %i[index create]

  root 'application#index'

 # Need this for prettifying url
  get '/', to: redirect('/#!/')
end
