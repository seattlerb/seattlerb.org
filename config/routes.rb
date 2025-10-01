Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  devise_for :admins
  devise_for :members, controllers: {
    registrations: 'members/registrations'
  }

  resources :suggestions, :only => [:index, :new, :create]

  resources :members, :only => [:index, :show, :edit, :update]

  resources :helps

  resources :posts, :only => [:index, :show]

  mount RailsAdmin::Engine => '/adminsrb', :as => 'rails_admin'

  get "/talks/past" => "talks#past"

  resources :talks

  get "/projects"   => "about#projects", as: :projects
  get "/join-us"    => "about#join_us",  as: :join_us
  get "/values"     => "about#values",   as: :values
  get "/events.ics" => "events#index",   as: :events

  root :to => "about#index"
end
