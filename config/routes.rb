Rails.application.routes.draw do
  root "main#index"

  get "main",    to: "main#index"
  get "values",  to: "main#values"
  get "join_us", to: "main#join_us"
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session,                     only: %i[new create destroy]
  resource :setting

  resources :locations
  resources :passwords, param: :token, except: %i[index show destroy]
  resources :projects
  resources :reviews
  resources :users

  post "users/run", to: "users#run", as: :user_run

  namespace :admin do
    root to: "dashboard#index"

    get "dashboard", to: "dashboard#index"
    post "pause",    to: "dashboard#pause",  as: :pause
    post "resume",   to: "dashboard#resume", as: :resume
    post "run",      to: "dashboard#run",    as: :run
    post "cancel",   to: "dashboard#cancel", as: :cancel
    post "switch",   to: "dashboard#switch", as: :switch

    mount MissionControl::Jobs::Engine, at: "/jobs" if defined? MissionControl::Jobs
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
