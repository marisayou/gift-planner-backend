Rails.application.routes.draw do
  resources :recipient_items
  resources :items
  resources :recipients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
