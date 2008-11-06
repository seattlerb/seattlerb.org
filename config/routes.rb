ActionController::Routing::Routes.draw do |map|
  map.root :controller => "about"
  # map.resources :projects, :dudes

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
