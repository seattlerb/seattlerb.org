SeattlerbOrg::Application.routes.draw do
  mount RailsAdmin::Engine => '/adminsrb', :as => 'rails_admin'

  devise_for :users

  get "talks/checklist" => "talks#checklist"

  resources :talks

  post "/newsletter" => "newsletter#subscribe", as: :subscribe

  match "/people"   => "about#people",   as: :people
  match "/projects" => "about#projects", as: :projects
  match "/join-us"  => "about#join_us",  as: :join_us

  root :to => "about#index"
end
