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

  resources :moderator, only: [] do
    member do
      delete 'destroy_post' => 'moderator#destroy_post'
      delete 'destroy_category' => 'moderator#destroy_category'
      delete 'destroy_location' => 'moderator#destroy_location'
    end
  end
  
  get 'pages/home'
  get 'pages/contact'
  get 'pages/about'
  get 'dashboard/dashboard'
  get 'dashboard', to: 'posts#dashboard'
  get 'admin', to: 'admin#dashboard'

#mods
  get 'moderator', to: 'moderator#dashboard'
  #categories
  get 'moderator/categories', to: 'moderator#mangeCate'
  get '/moderator/new_category', to: 'moderator#new_category'
  post '/moderator/create_category', to: 'moderator#create_category'
  get '/moderator/edit_category/:id', to: 'moderator#edit_category', as: 'moderator_edit_category'
  patch '/moderator/update_category/:id', to: 'moderator#update_category', as: 'moderator_update_category'
  #locations
  get 'moderator/locations', to: 'moderator#manageLoc'
  get '/moderator/new_location', to: 'moderator#new_location'
  post '/moderator/create_location', to: 'moderator#create_location'
  get '/moderator/edit_location/:id', to: 'moderator#edit_location', as: 'moderator_edit_location'
  patch '/moderator/update_location/:id', to: 'moderator#update_location', as: 'moderator_update_location'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
