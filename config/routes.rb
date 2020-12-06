Rails.application.routes.draw do
  resources :search_items
  resources :recipient_items
  resources :items
  resources :recipients

  resources :recipients, only: [:index, :show] do
    resources :recipient_items, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
