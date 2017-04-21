Rails.application.routes.draw do
  resources :questions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'send', to: 'deductor#send_params'
  get 'post_xml', to: 'deductor#post_xml'
end
