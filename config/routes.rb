SeattlerbOrg::Application.routes.draw do
  resources :suggestions, :only => [:index, :new, :create]

  resources :members, :only => [:index, :new, :create]

  resources :groups, :only => [:index, :new, :create]

  resources :comments, :only => [:index, :new, :create]

  resources :helps

  resources :posts, :only => [:index, :show]

  mount RailsAdmin::Engine => '/adminsrb', :as => 'rails_admin'

  devise_for :admins

  get "/talks/past" => "talks#past"

  resources :talks

  post "/newsletter" => "newsletter#subscribe", as: :subscribe

  get "/projects" => "about#projects", as: :projects
  get "/join-us"  => "about#join_us",  as: :join_us

  root :to => "about#index"
end
