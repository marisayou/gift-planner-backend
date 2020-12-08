Rails.application.routes.draw do
  resources :notes, only: [:index, :create, :destroy]
  resources :search_items, only: [:index, :create]
  resources :recipient_items, except: [:new, :edit]
  resources :items
  resources :recipients

  resources :recipients, only: [:index, :show] do
    resources :recipient_items, only: [:index, :show]
  end

  resources :recipients, only: [:index, :show] do
    resources :notes, only: [:index, :show]
  end

  delete "/search_items", to: 'search_items#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
