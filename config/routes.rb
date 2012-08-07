SeattlerbOrg::Application.routes.draw do
  
  resources :dudes, path: '/admin/people'
  
  root :to => "about#index"
  match "/people"   => "about#people"
  match "/projects" => "about#projects"
  match "/join-us"  => "about#join_us"
end
