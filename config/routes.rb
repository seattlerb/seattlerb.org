SeattlerbOrg::Application.routes.draw do
  root :to => "about#index"
  match "/people"   => "about#people"
  match "/projects" => "about#projects"
  match "/join-us"  => "about#join_us"
end
