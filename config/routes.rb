Rails.application.routes.draw do
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
