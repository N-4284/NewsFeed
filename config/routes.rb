Rails.application.routes.draw do
  resources :posts
  devise_for :users

  resources :admin, only: [] do
    member do
      put 'promote' => 'admin#promote'
      put 'demote' => 'admin#demote'
      delete 'destroy_user' => 'admin#destroy_user'
    end
  end
  
  get 'pages/home'
  get 'pages/contact'
  get 'pages/about'
  get 'dashboard/dashboard'
  get 'dashboard', to: 'posts#dashboard'
  get 'admin', to: 'admin#dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
