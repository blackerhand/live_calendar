Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :partners, only: [:index]

  resources :free_times, only: [:index, :create, :destroy] do
    post :reserve, on: :member
  end
end
