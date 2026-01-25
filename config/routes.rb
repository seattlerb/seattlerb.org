Rails.application.routes.draw do
  root "main#index"

  get "main",    to: "main#index"
  get "values",  to: "main#values"
  get "join_us", to: "main#join_us"

  resources :projects
  resources :users
  resource :session,                     only: %i[new create destroy]
  resources :passwords, param: :token, except: %i[index show destroy]

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
