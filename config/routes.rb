SeattlerbOrg::Application.routes.draw do

  scope "admin" do
    resources :dudes, path: ''
  end

  get  "/newsletter" => "newsletter#index",     as: :newsletter
  post "/newsletter" => "newsletter#subscribe", as: :subscribe

  match "/people"   => "about#people", as: :people
  match "/projects" => "about#projects", as: :projects
  match "/join-us"  => "about#join_us", as: :join_us
  root :to => "about#index"

end
