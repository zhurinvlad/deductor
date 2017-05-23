Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :questionnaires, only: [:show, :update]

  # Для VK(2-я группа)
  get 'send', to: 'deductor#send_params'
end
