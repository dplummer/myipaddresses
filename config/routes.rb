ActionController::Routing::Routes.draw do |map|
  map.resources :ips
  
  map.root :controller => :ips

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
