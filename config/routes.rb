Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'send', to: 'deductor#send_params'
  resources :questionnaires, only: [:show, :update]
  get 'post_xml', to: 'deductor#post_xml'
end
