SeattlerbOrg::Application.routes.draw do
  
  get  "/newsletter" => "newsletter#index",     as: :newsletter
  post "/newsletter" => "newsletter#subscribe", as: :subscribe
  
  resources :dudes, path: '/admin/people'
  
  root :to => "about#index"
  match "/people"   => "about#people"
  match "/projects" => "about#projects"
  match "/join-us"  => "about#join_us", as: :join_us
end
