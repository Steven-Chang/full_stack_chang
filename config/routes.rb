# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'entries/by_date' => 'entries#by_date'
  resources :entries, only: %i[update destroy]
  resources :scores, only: %i[index create]
  root 'application#home'
end
