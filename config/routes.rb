SeattlerbOrg::Application.routes.draw do
  
  get  "/newsletter" => "newsletter#index",     as: :newsletter
  post "/newsletter" => "newsletter#subscribe", as: :subscribe
  scope "admin" do
    resources :dudes, path: ''
  end
  
  root :to => "about#index"
  match "/people"   => "about#people", as: :people
  match "/projects" => "about#projects", as: :projects
  match "/join-us"  => "about#join_us", as: :join_us
end
