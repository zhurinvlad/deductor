Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'send', to: 'deductor#send_params'
  get '/questionnaires/:id', to: 'questionnaires#show'
  get 'post_xml', to: 'deductor#post_xml'

  root 'questionnaires#show'
end
